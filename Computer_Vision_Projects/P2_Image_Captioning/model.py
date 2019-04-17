import torch
import torch.nn as nn
import torchvision.models as models


class EncoderCNN(nn.Module):
    def __init__(self, embed_size):
        super(EncoderCNN, self).__init__()
        resnet = models.resnet50(pretrained=True)
        for param in resnet.parameters():
            param.requires_grad_(False)
        
        modules = list(resnet.children())[:-1]
        self.resnet = nn.Sequential(*modules)
        self.embed = nn.Linear(resnet.fc.in_features, embed_size)

    def forward(self, images):
        features = self.resnet(images)
        features = features.view(features.size(0), -1)
        features = self.embed(features)
        return features
    

class DecoderRNN(nn.Module):
    def __init__(self, embed_size, hidden_size, vocab_size, num_layers=1):
        super(DecoderRNN, self).__init__()
        self.hidden_size = hidden_size
        self.num_layers = num_layers
        self.embed = nn.Embedding(vocab_size,embed_size)
        
        self.lstm = nn.LSTM(input_size=embed_size,
                           hidden_size=hidden_size,
                           num_layers=self.num_layers,
                           batch_first = True)
        
        self.linear = nn.Linear(hidden_size,vocab_size)
        
    def forward(self, features, captions):
        embeds = self.embed(captions[:,:-1])
        features = torch.cat((features.unsqueeze(dim=1),embeds),dim=1)
        
        output,_ = self.lstm(features)
        
        output = self.linear(output)
        
        return output

    def sample(self, inputs, states=None, max_len=20):
        " accepts pre-processed image tensor (inputs) and returns predicted sentence (list of tensor ids of length max_len) "
        hidden = None
        res = []
        for i in range(max_len):
            outputs, hidden = self.lstm(inputs, hidden)
#             print('lstm output shape ', outputs.shape)
#             print('lstm output.squeeze(1) shape ', outputs.squeeze(1).shape)
            outputs = self.linear(outputs.squeeze(1))
#             print('linear output shape ', outputs.shape)
            target_index = outputs.max(1)[1]
#             print('target_index shape ', target_index.shape)
            res.append(target_index.item())
            inputs = self.embed(target_index).unsqueeze(1)
#             print('new inputs shape ', inputs.shape, '\n')
        return res