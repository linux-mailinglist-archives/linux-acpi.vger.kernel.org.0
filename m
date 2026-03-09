Return-Path: <linux-acpi+bounces-21564-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGVFE9H/rmkLLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21564-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:13:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DC23D78C
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF833001587
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3F8296BD7;
	Mon,  9 Mar 2026 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XtQjHwLp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD83BE162;
	Mon,  9 Mar 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076427; cv=fail; b=A3eRViUxiklcO1x1Rxfg9KlFLC/9Fm6D1JJPH1z1SJdE7gT8iTGXy2kcuBuEltyOwU1iiBaFtq9bYue2m+C6Z2B7akN+UV1BTtdfKVlm4KJenA86ZKcOjlO8OWpczM8h1QjZcfJV/FLjLd32fdBUEQlhuOVWKdHsgDkoNRamR+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076427; c=relaxed/simple;
	bh=WtQklroeG9+iikT48DjXUvpgyixzj1UCH9mmPAS76rA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D2W0S3H5p0WN+btcOSRsFCm9vWcwn50vn+SZrT7MbbftF2CW86XCBW09OLlqsrkWUT+q/QYjWUQza5rXtLYNVptBMsieqSD7drPUfQJyPcDrWwQp4uCpcUM/dvJe0HaupiIHt8x4RA0ZLiAXw+ct8FAeKugQpJrf3YwKyEalmfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XtQjHwLp; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773076425; x=1804612425;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WtQklroeG9+iikT48DjXUvpgyixzj1UCH9mmPAS76rA=;
  b=XtQjHwLpOn/j2SlKhI0Z6l1CqtbpwYDF6oBs0LA9sh03NeQvQGj4jI8U
   tiJXN/EzEMEqQv0jpl7tFcv9xNfisatglxNg1SukKIAd/vsMX18R7SFRP
   0G3Njig6rdUaFpWmkTMEEpdIKiiufbCLKABKKUdNduwAAimepLQtRT9BT
   JEDHVxW7NEQ7HJBRhihYSpgyXnxBSUyGyhygjJZlhFocBzaG4MGyMDEMh
   +X6tv86J9b0gPRsZCPQkY5L8nYTBz5Tk1LT+vdX42/m+y3x3bZsvTR1Ez
   GI/ziIplgdYQkSt6wK5NsLqM77/3gjABVR5q/JPshCj0z2LvG/hs9vcPW
   g==;
X-CSE-ConnectionGUID: N7gs+Y4rQoONGRsvHtkGGg==
X-CSE-MsgGUID: p9wsO1AqTZasnS5kIZjCEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85197135"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="85197135"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 10:13:44 -0700
X-CSE-ConnectionGUID: HXMrUaESSFKHXAJG4v+d7w==
X-CSE-MsgGUID: GQr9cC2vSmaJX0INKLWSoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="224514535"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 10:13:45 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 10:13:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 10:13:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 10:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDlgdpOaYK+gzum4aEtISPgFZ4bK5MoIllwm08Z2Ygjw54VzZ/fjKbcNgisO9PHCDF/Db0nfND0b4GEnw8dO2PbLqlM1cKuPoiYLbSlSBUXnfU18sfJ3EUzJql6PhY37f+bJZQY1Vh1bISpCdFMUOAJ94haYKhk0ckUp6sCKDQ7PZR9OQ8ApPErtMhbvT0RFstRrCJv4KIKXLyzdUMYE1L65Pl6nY8XveOICkPpAB/8NJ2tRgU3l9np3+EGLiImkzzZaEMP2l4uNmCzJ68iY+5oVoHIa2VU6IojZ7tq556DksWL0qcgxfN7Civ/WcDB45zURgFlaPsUZWclVQsgIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IxI6i7kKN/0XmiQiikmU+59tw4zYz8SwoNA16pa91qo=;
 b=oa7uGdTTB98EJ/fv6cIZkTBFi7B2mIEbfOrcdHvPi4EtDabRoqHB+AOgaCIpSXt7Mq7rPMzdUJ0S7evl4qreQVpuDZ54RIhxJu/UteWJZwhPwrJw+9G8PYM6fFkCPrv0oVpaCFp0pKdyAcU2WOm+Zb9v4b1scjAi3N5w9eK8z9yJR+TaMmZDT5ULSYrUVfAA8tWc39okFWLdwa8o6CVu+1CDWwYXpL60n+7HWwf9sh2/Mh/I5DR/BihYxfaQ31kimchz3JF1YHzpahNgqe4aS2/g8TQ/0dMTBE/XGdp7yXesosOgsdEyxCJ9X2AxOJKH/SCk7CVVAvKarnvER0bKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 17:13:41 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 17:13:41 +0000
Date: Mon, 9 Mar 2026 10:13:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Kai Huang <kai.huang@intel.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <dan.j.williams@intel.com>,
	<akpm@linux-foundation.org>, <nunodasneves@linux.microsoft.com>,
	<xueshuai@linux.alibaba.com>, <thorsten.blum@linux.dev>, <gourry@gourry.net>,
	<wangyuquan1236@phytium.com.cn>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is
 on
Message-ID: <aa7_wBXAVuzsbmYi@aschofie-mobl2.lan>
References: <20260308222313.14014-1-kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260308222313.14014-1-kai.huang@intel.com>
X-ClientProxiedBy: SJ0PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::17) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 905a763e-10a2-4f8b-3bce-08de7dff362a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: QHBTjRG0ZAWuc94oyaMltVI1KfSU0be7fWWOi7ydsqms9Jt1WqOYf+VkeOiIdmd1MT+HuT52DJRYa8ZEfz7+T7Ta9VWS/IywI3uClqB5DLcD6wTzPDHOSgQQ89GEZaVyrfyQ5XstnXTSULGVgj5LSLf9bfMc3L/ajTPmChxgMQCouGnE9FhNWQjgtLyMXX1KdzgQPOm7AWO1/jyMQh54IiVLoqAeefWt44/YFHb9BFmGQG02Uw5DCUlXJeZcCl/Qwbc39jw5I3VwB7K1+pD83D2lWTsx8jELAwDMBOQ1FvEy1Uhoi8wLFqwd3gVGioK+o+TjkArqyR2HUPiOXj/XNx4BVtSBn9taMRs0mn725hx/4CqyzmbaZHU0u7+dKAx+Da+IsuTMOqg+CErax8r/6CG0eNOw0ed6zdCLIztdSLAFEdQkDcCUMO3OiHql9/LxWwU6f5gkF4hFQU3qTDFPqz/v4hgcXTHRIdlsrMn1O42BGvjibIJbkniILzPESFkxSHi80Lqx+mEvsJbOeWOiUpJawidN4mkswwjL6wSKL+pKFPxSXfXPViHeoaWXvZhUm+Kq/0W97EebGAUIgFXbs+KuUHqtB3W2A1Z61R/yvG03qL7CfxU1eYmOo4RJXw4TKO4vdT4fJqziZAxbqsIlOBuS5i3JGZ6gvk3f0UhLeEBqdESpU+08NdNEeYXen8zo3GUAAZSbJ/mopzG4QJk6NfGc2wLlHBTRCax73QLEsVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5VxjmZZIYNJj8aB+XJ/ST96i/pPZY8lS+mDbaMaPhr7Fk3MH3kvMJctW/pk?=
 =?us-ascii?Q?DbDf6vRotaOKZ9UXbo5gEpVgI7PWNgJh8dT++Y4wE36dfgflpLi0O2fqXrLR?=
 =?us-ascii?Q?MlbVWdwlZAxbLCgbBapM/8imp0r/YFTozggB5iShL/bcrJtmpRW354Hh6e/z?=
 =?us-ascii?Q?n6yaOegV/gSIFkVtkQ99JF+L/c+E5nyNBfeK4jShdi8Tc2XOmDYl+NHukzpE?=
 =?us-ascii?Q?m0VPkpZq8GkTEOgeAQRToC9Zj12tXKcQTIkzEre0xJ2TUIivkjSU6gxPQd0F?=
 =?us-ascii?Q?COvi7pMIshnA6ifGCbnUilK9yRdGPWImI1mfFMmtTXGJkw5V440LyV8GRBAB?=
 =?us-ascii?Q?1ru67gQVAMJhWfjH5O5dDfqGTm2rWUnlgPEuH6ZC2oJzBVSZEW88dVBy/cu3?=
 =?us-ascii?Q?/bnbQvRMif72a4s9IqpIKtQAz6xFn9E54mALdo8gax0xvvAaSzyJgxwtxQ93?=
 =?us-ascii?Q?TvxeqnAvqlvAhRh49MFIkjNqJsQ9CnocmPZV2Jk4qJ/GgAbX94s61cqoPBRn?=
 =?us-ascii?Q?ebh206NT7rFwp0iRYy2ALPP0CMHhu4wRk3O/Cs/0lGvcIXsMP9UpPRjfFHuo?=
 =?us-ascii?Q?p2d5SBMzHg6rFprIAyAuLfY+gKeX2J8PkYT/sXUkWhkfXN/c4ykVmFz88Q2S?=
 =?us-ascii?Q?WtYFdknzmN53ArOzf5ETIXmwkisva7slfoaL3nH2moWR2c3phG/hvLU16be2?=
 =?us-ascii?Q?EG1vKDkaVHVleucSteLuszczQ8i4w/Tgc8n2ZQALcnnaN2bohV1IE3LopEMt?=
 =?us-ascii?Q?EqqE4VQO9+j74Bm3b8StPPs5DqqqMV67tMbRtxA0CAx6PaiD4SqFNzbxdNcX?=
 =?us-ascii?Q?ec1/SSO6uStHNa0b7ld96QcGmUTEVJjZzgwzFVGRjkS0I+F3dV9m0oOI8IvM?=
 =?us-ascii?Q?ksJ3JDwDVfAQaWnJciAdOEYUrQi0W2NyaxfPJPowMKT/ZdM0D4hxRpgFDqi8?=
 =?us-ascii?Q?/PB+odaoCxwWkx0Ik36EpQOL+9zItl3hhD8jM4Xk/+jyoXybn5XsCow5eLas?=
 =?us-ascii?Q?hDZJNfC8G9r/gmOMn/hcsSfhjTMBkgDOlmFQnRrNH3By+Q6ILnfrbO6XIiTv?=
 =?us-ascii?Q?rn6hf+dY5knCNhJL5Egc5gDbSfSqWy/4CildbQETPs38oeeDhh4bKGcyxUiO?=
 =?us-ascii?Q?1f9WQY523W1+ui7+OlRtP1v0+RPs/j5WbSNOcUTWP4ntZ5R+Vuf6v9uFsTxC?=
 =?us-ascii?Q?1n1/vEzeVlXy7TvBRywvU9VSCtjETMJgCt6fLF8yXp20RfnZwNrob4d2HrSf?=
 =?us-ascii?Q?yVaTzRKvIbYegfmrbwRkYssMnlR7XBJb8uuQ550aiT6z+4aiAYi9UHA37png?=
 =?us-ascii?Q?nbEMp1uibWfehdzoelLTjmprgwXNlR0blgbafWC9khnwcrs8MaYkGbkWjGz+?=
 =?us-ascii?Q?EnhkvqmMkZaMtARXLTbjbiWLDEe72nn/+9GL688JGVPCbFNpGOgbCpa3B8Tx?=
 =?us-ascii?Q?lb3wrTyFcaXIpAyOx3Wg0i2FqeXT2ARPuh/TCpxhNzGBGOWxX/z2x8JzqaKZ?=
 =?us-ascii?Q?kJv35kcEp9h/MV1IP1uXO2rin7axdJFGhH41/O7OK1LeC8lC7qZDdJL0QFUo?=
 =?us-ascii?Q?v+X5496c7tf6I4gXQr0xGJYvvE5paWORKRM92x9x9vva3qGgCkNHlVvvJQb+?=
 =?us-ascii?Q?XIaFWdqQVNib+tNDYM5qaphGuqqtCihXXXybeIycToLqGZa/C48ASwB1JUsZ?=
 =?us-ascii?Q?hPV+J34o6t7uLZiYQvuKLIYDsiglDN97EFAWzWF2duNzDkLj08GYK97sIgwz?=
 =?us-ascii?Q?n5Uf38GaDhXol4M8HP0P1PzGJhd1d60=3D?=
X-Exchange-RoutingPolicyChecked: BDUUbwB1U0r8NIuvTlnG+LlRpWuoVscOL5E1DzHnbntw750xVzoZDclFEdJ17ajIT7vXwtqdi2utY0lk3hN3andhF9/6r6DKrHtV/FKrXDlQhELTjULabXnUvM6CXiu0OQXROPtILVadiXxFwohmSRVVACWpafCxDr979Ep+krOKlly6o9CwtQM+UTXY/uC9q7Qp66GUgYCdpLunsxsb1dzPN1VaK4GWCckaOqln43Zj2cb/Ii2KvK9kKAStj921MKhb2kna3ivS17K82vPiCz2xBSk6TBmI5Kf1asdBf926y4HyO4QnwF2SWg/AaSJr6BDLFQPhVg3cT79XI72sNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 905a763e-10a2-4f8b-3bce-08de7dff362a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 17:13:41.4538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN4lXUJdyPlV6j2KtqhuaBavQtL8X5GIWkCc9XBIiSWEqQoaDuqLgaHW8hK8blOI1LiFkOD61Ui2a3lO3sW8ClI4GFItly9uJv0GB5NEdh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 574DC23D78C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21564-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,aschofie-mobl2.lan:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alison.schofield@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:23:13AM +1300, Kai Huang wrote:
> On CXL platforms, the Static Resource Affinity Table (SRAT) may not
> cover memory affinity information for all the CXL memory regions.  Since
> each CXL memory region is enumerated via a CXL Fixed Memory Window
> Structure (CFMWS), during early boot the kernel parses the CFMWS tables
> to find all CXL memory regions and sets a NUMA node for each of them.
> This memory affinity information of CXL memory regions is later used by
> the CXL ACPI driver.
> 
> The CFMWS table doesn't provide the memory affinity information either.
> Currently the kernel assigns a 'faked' NUMA node for each CXL memory
> region, starting from the next node of the highest node that is
> enumerated via the SRAT.  This can potentially increase the maximum NUMA
> node ID of the platform ('nr_node_ids') a lot.  E.g., on a GNR platform
> with 4 NUMA nodes and 18 CFMWS tables, this bumps the 'nr_node_ids' to
> 22.
> 
> Increasing the 'nr_node_ids' has side effects.  For instance, it is
> widely used by the kernel for "highest possible NUMA node" based memory
> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> related system calls such as 'get_mempolicy' which requires 'maxnode'
> not being smaller than the 'nr_node_ids'.
> 
> Currently parsing CFMWS tables and assigning faked NUMA node at boot is
> done unconditionally.  However, if the CXL ACPI driver is not enabled,
> there will be no user of such memory affinity information of CXL memory
> regions.
> 
> Change to only parsing the CFMWS tables at boot when CXL_ACPI is enabled
> in Kconfig to avoid the unnecessary cost of bumping up 'nr_node_ids'.
> 
> E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> reduced with this change (when CXL_ACPI is off):
> 
> 	w/ this change		w/o
> 
> Slab	900488 kB		923660 kB
> 
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> ---
> 
> v1 -> v2:
> 
>  - Use Dan's suggestion to simplify the diff:
> 
>  https://lore.kernel.org/linux-cxl/69a8dc7ca72c2_2f4a10026@dwillia2-mobl4.notmuch/
> 
> Hi Alison, Gregory,
> 
> I didn't add your RB since the code now is different from that you
> reviewed.  Appreciate if you can take a look again and provide the tag
> if the patch looks good to you.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


