/// Constants used throughout the Hyperliquid SDK
class BaseUrls {
  static const String production = 'https://api.hyperliquid.xyz';
  static const String testnet = 'https://api.hyperliquid-testnet.xyz';
}

class WssUrls {
  static const String production = 'wss://api.hyperliquid.xyz/ws';
  static const String testnet = 'wss://api.hyperliquid-testnet.xyz/ws';
}

class ChainIds {
  static const String arbitrumMainnet = '0xa4b1'; // 42161
  static const String arbitrumTestnet = '0x66eee'; // 421614 - testnet//Arbitrum Sepolia
}

class Endpoints {
  static const String info = '/info';
  static const String exchange = '/exchange';
}

enum InfoType {
  allMids,
  meta,
  openOrders,
  frontendOpenOrders,
  userFills,
  userFillsByTime,
  userRateLimit,
  orderStatus,
  l2Book,
  candleSnapshot,
  perpsMetaAndAssetCtxs,
  perpsClearinghouseState,
  userFunding,
  userNonFundingLedgerUpdates,
  fundingHistory,
  spotMeta,
  spotClearinghouseState,
  spotMetaAndAssetCtxs,
  predictedFundings,
  spotDeployState,
  tokenDetails,
  maxBuilderFee,
  historicalOrders,
  userTwapSliceFills,
  subAccounts,
  vaultDetails,
  userVaultEquities,
  userRole,
  delegations,
  delegatorSummary,
  perpsAtOpenInterestCap,
  delegatorHistory,
  delegatorRewards,
  validatorSummaries,
  vaultSummaries,
  blockDetails,
  txDetails,
  userDetails,
  userFees,
  portfolio,
  preTransferCheck,
  referral,
  extraAgents,
  isVip,
  legalCheck,
  userTwapSliceFillsByTime,
  twapHistory,
  userToMultiSigSigners,
  builderFeeApproval,
  userOrderHistory,
}


enum ExchangeType {
  order,
  cancel,
  cancelByCloid,
  scheduleCancel,
  modify,
  batchModify,
  updateLeverage,
  updateIsolatedMargin,
  usdSend,
  spotSend,
  withdraw3,
  spotUser,
  vaultTransfer,
  createVault,
  vaultDistribute,
  vaultModify,
  setReferrer,
  registerReferrer,
  usdClassTransfer,
  twapOrder,
  twapCancel,
  approveAgent,
  approveBuilderFee,
  evmUserModify,
  claimRewards,
  createSubAccount,
  setDisplayName,
  cDeposit,
  cWithdraw,
  tokenDelegate,
  subAccountSpotTransfer,
  subAccountTransfer,
  reserveRequestWeight,
}

class Websocket {
  static const String mainnetUrl = 'wss://api.hyperliquid.xyz/ws';
  static const String testnetUrl = 'wss://api.hyperliquid-testnet.xyz/ws';
}

const String sdkCode = 'PLACEHOLDER';