import { useBackend } from '../backend';
import { Window } from '../layouts';
import { NumberInput, Section, Stack } from 'tgui-core/components';

type Data = {
  master: number;
  music: number;
  ambience: number;
  lobby: number;
};

type VolumeRowProps = {
  label: string;
  value: number;
  id: string;
  description: string;
};

const VolumeRow = ({ label, value, id, description }: VolumeRowProps) => {
  const { act } = useBackend<Data>();

  return (
    <Stack align="center" mb={1.5}>
      <Stack.Item basis="50%">
        <b>{label}</b>
      </Stack.Item>
      <Stack.Item grow>
        <NumberInput
          minValue={0}
          maxValue={100}
          step={1}
          value={value}
          width="100%"
          onChange={(newValue: number) =>
            act('set_volume', { id, value: newValue })
          }
        />
      </Stack.Item>
      <Stack.Item basis="10%" textAlign="right">
        %
      </Stack.Item>
      <Stack.Item basis="100%">
        <span className="color-label">{description}</span>
      </Stack.Item>
    </Stack>
  );
};

export const VolumePowerMenu = () => {
  const { data } = useBackend<Data>();
  const {
    master = 50,
    music = 50,
    ambience = 50,
    lobby = 50,
  } = data;

  return (
    <Window width={470} height={340}>
      <Window.Content>
        <Section title="Volume Levels" fill>
          <VolumeRow
            label="Master"
            value={master}
            id="master"
            description="Non-music and non-ambience sounds."
          />
          <VolumeRow
            label="Music"
            value={music}
            id="music"
            description="In-round music channels and admin music."
          />
          <VolumeRow
            label="Ambience"
            value={ambience}
            id="ambience"
            description="Ambient and environmental loop channels."
          />
          <VolumeRow
            label="Lobby Music"
            value={lobby}
            id="lobby"
            description="Title/lobby music playback volume."
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
