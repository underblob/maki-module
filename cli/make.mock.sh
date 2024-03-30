MOCK_EXAMPLE_REACT_SCSS=$(cat <<-EOF
#folder-mc-fern, #folder-mc-fern * {
  background-color: rgba(153, 255, 153, 0.10);
  outline: solid 1px rgba(153, 255, 153, 0.50);
}
EOF
)

MOCK_EXAMPLE_REACT_JS=$(cat <<-EOF
import './folder-mc-fern.scss';

class FolderMcFern extends React.Component {
  render() {
    return (
      <div id="folder-mc-fern">
        <pre>Component: FolderMcFern</pre>
      </div>
    );
  }
}

FolderMcFern.propTypes = {};
FolderMcFern.defaultProps = {};
EOF
)

MOCK_EXAMPLE_REACT_TEST=$(cat <<-EOF
import FolderMcFern from './FolderMcFern';

describe('FolderMcFern', () => {
  describe('<FolderMcFern/>', () => {
    describe('render()', () => {
      it('matches snapshot', () => {
        const instance = shallow(<FolderMcFern/>).instance();
        const result = instance.render();
        expect(result).toMatchSnapshot();
      });
    });
  });
});
EOF
)

MOCK_EXAMPLE_REACT_INDEX=$(cat <<-EOF
import index from './FolderMcFern';

export * from './FolderMcFern';
export default index;
EOF
)

MOCK_LINEAGE_MD=$(cat <<-EOF
# OneMe Tokens

## Lineage

- Single parent: grand
- Single child: child
- Cascading parents: grand, great-grand, ggg-granny
- Cascading children: child, grand-child, great-child

## Casing

| Convention | Self token    | Parents         | Children       |
| ---------- | ------------- | --------------- | -------------- |
| Camel      | oneMe  | grand  | child  |
| Constant   | ONE_ME | GRAND | CHILD |
| Kebab      | one-me | grand | child |
| Pascal     | OneMe  | Grand  | Child  |
| Snake      | one_me | grand | child |
EOF
)
