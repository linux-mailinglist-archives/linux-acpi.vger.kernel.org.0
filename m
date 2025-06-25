Return-Path: <linux-acpi+bounces-14652-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0BAE9040
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE066A185C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F3724A049;
	Wed, 25 Jun 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPInCKol"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67A1F4CAF;
	Wed, 25 Jun 2025 21:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750887561; cv=fail; b=jVV+HRCxElziMEQE9QvZx9MdJmxf/H118ij7m0yba8+xi71boz0LaPOFL7JGvlbFG9Z0Z7PXnacefeV15TGDej+2iA4AbzVMMxwHmWNjVGLOBSyMOnFAix6OOQSaHYUkDiRHxN3zvBOJho4Y3RO4XwMZTHn6ma2r2u3UjXnk4p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750887561; c=relaxed/simple;
	bh=3CsIqei4MF19WAUCLz4OSdqBCuv02EcwsU+P1IPZxqA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LiayxIlXjyI3e8T4TJ8Q9iGNegPIaKbmHn6dc59ak2ztBlrvBJe0kcM13tbPKC/RzfsTXgnG2zGY9sH0TcCMaWZCtW/RLNNmeG+cNIPgLhT+Yxycv+m13QEhNGNUb4e6UPeB7shUNOv7cHDNSbb46OROOHbSRIBVdyUSPJAdhmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPInCKol; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750887560; x=1782423560;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3CsIqei4MF19WAUCLz4OSdqBCuv02EcwsU+P1IPZxqA=;
  b=KPInCKolPKOdqTX4F/rONjCZNmywH1ufKXP5WCiqkmucybtfUPWZF76L
   f9QbI6tGJJjTcUIQ8VH3N3PxAVinQSgze1ahVe1PQmyW3DeSlwm2R6JaZ
   oDXZtbV+A+0/ZGoHV/ZzVO6qSyd67DQgsyyd9WEJwAKzJzr2ZkyLgL3e0
   NZluf/vFZ7WDJuA5Hp1yRqSKZnQFmX5SMdiKJWwFZVPpTYvVtIBMzDC/a
   6Vu3fgKYpUZNNoe8U1Iyqd2Su2sLr9+ToyvlkZGRuSH+XDYW9/iop4VX1
   0MxdM5FDK4b3yWyHsUSVyZeYvWXK/JCJJFVGAE8l0cVmtf2n4uHAmWXBG
   w==;
X-CSE-ConnectionGUID: JVHEZo/eTUezKB9f+fh7Tg==
X-CSE-MsgGUID: qv0D1trnTb6h7/nL7vvTyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="64527528"
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="64527528"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:39:19 -0700
X-CSE-ConnectionGUID: p/RL8ZetTpqEYU1EostniQ==
X-CSE-MsgGUID: 9sgtxoUyRjuogr+F4fDEUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,265,1744095600"; 
   d="scan'208";a="156593195"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2025 14:39:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:39:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 14:39:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.81)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 14:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJPWsu84b9i1KpvifUUxSQBajrOuODuU4OLzuqh5/RoImNTvNKl6oGnK+MGpG0UdoLI6aV9IxPk7sMYr7KQKnff8wycClF73i5qUlEWmGhlQ2MSmqx5K4gK9LqzqfKvbnqb/zKRn8F7QwiVf6IlCCtGXiD7JyWuBqcwNxnFHLQXpFnw+A/2lEub5p0pPFo7OLO0MWIplJ8WYpXeSJaLYvqaT6crbFGpmIZyyfN50x1I35Rm6PqzYztbdkmjVuXoWn3nk2gKI/jLmCXer8nuVx4ZuJQw0DJmRNpym29XsK9YfdQ8ScXKnBeBvqPd6h9+fgDv9fHQbBOORBM/I+n6iMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKe0ZKAf5Gbslbxud/EouPA494s8WatlvpqeSwv1hqc=;
 b=lBIxV8NBssPOZB84iB9j0j80U5+P5ACBE8aYMLJdEQoUHwgYUwhzqQyqui/ccENqaF6bxMYHs6XbSgEIfBdX+I+/wGfNw5lz5QrfGBMWCt/l0kNb5dDVSPd34MgTFKHAXbdhJE15ZgrJpzy2TyfkDJvH3GQmt8VFns1OsQ2fNyfNzGlZUigJgbtO6HhqahVHtUnnjYoAPmSmE4jTgH//C96OqeoA1N86jScUa0Q+IdwkKWAexQKmP8Zam+K/FeDeumM4qGY8x2KBzSqO1eN6pOKMz+OG2BpUFVRFkD8wEK/Q9BY9vDTYsHUA+ZyH3tc0mGvs3ea+xLhyYZcXnRL6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by DS0PR11MB7506.namprd11.prod.outlook.com
 (2603:10b6:8:151::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 21:39:15 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::19ef:ed1c:d30:468f%4]) with mapi id 15.20.8835.018; Wed, 25 Jun 2025
 21:39:15 +0000
Date: Wed, 25 Jun 2025 16:40:35 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, James Morse
	<james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov
	<bp@alien8.de>, Ira Weiny <ira.weiny@intel.com>, <linux-acpi@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
Message-ID: <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch>
References: <20250624202937.523013-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250624202937.523013-1-colin.i.king@gmail.com>
X-ClientProxiedBy: MW4PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:303:dc::22) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|DS0PR11MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 55766add-0e3e-4001-b36c-08ddb430bb2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IzkNLL+KmnuLNPz//QJ8lt8NuUqzDoKtzvs4MAlgdgiXXpA8+POfDcsNHOR+?=
 =?us-ascii?Q?YrgPrWFIjWxT6utmnJgX51b8RkpIcm/LhFDQjdMEVqAiBGPz79pErjDCXXJa?=
 =?us-ascii?Q?5u1KKPfFbYK1JH5RFb4pgHil2s0zcTs4XU8JCXjOnSd1HSDK/jozMHyoRM6k?=
 =?us-ascii?Q?Qs6yELlJjTqpo+LnebB3UV4jCywtUcje86tndg7m16mkgU/CdELLd7YTqu7o?=
 =?us-ascii?Q?cMLEFNAcGEW8vgZCDxQbkd5Dwu5mSyR4xCyV6Zwcn+g2kuKMYuI5xc4Sh0jx?=
 =?us-ascii?Q?Lvj0L1l37z12QXNlZyCJgjSgB/uiUSE5PpowRL7rBOvCT8xncBV61TffwrA/?=
 =?us-ascii?Q?tBAcFKodWr/tKitOoGKOVVFGoGSurtF1s+5JxpyRjDh6J4JOo2/JAJdDuS+T?=
 =?us-ascii?Q?8huz0MWBnO9m9o+T9K+rkt+Ro8QJsHv0UPEuaYZ99T+Q5ISSS6I8oAqi9Q7r?=
 =?us-ascii?Q?ct6g5ased1ggkiozmduN7UqICnbdZCvab5fMZ3ociQrC4otiKeYYsDOYge7I?=
 =?us-ascii?Q?tiq/5iiQexdWPUmPBtdDNj4a22th2oBTs/UvzN8zMqwnpprk9p1Ek2+jj22e?=
 =?us-ascii?Q?eQttXX/Ww8wqHL3MI1/xHM/RF1abnYnqaNf320rRYudlD0S8X+Y43oecPtIx?=
 =?us-ascii?Q?dvKHAfe7k3L9ALdEDeZD5wpgUqXRY6pBN3ayb6XXmlyIxQVecY5HVAyg0MgK?=
 =?us-ascii?Q?IyQLWmjhq0ee1yCxpevPT/P3/2LHCbbgWxEA7UOofIOJUDqCFxD9DdIs6sdP?=
 =?us-ascii?Q?V+iJZ0iawSTBibe395zUAtaotEUxGli/W56iyJUK06IDz/cwXAdoWRjLv+mt?=
 =?us-ascii?Q?eNtyM4VhPTFTZUmbjySmfGIWb5/zh9YAZaPhb5wkm+LPFbQSNyI359N1xhII?=
 =?us-ascii?Q?V0ceIWRdm6saATB1gFY9GE+oN2N0LHME860b4CenBi4VlSN78/Ml6Au2VhDf?=
 =?us-ascii?Q?KL1Z5iwByPHhYPnFrxzQqeLZkEU7DyZ4/BesTZphD++F+7HWRDtCoXPGMwsH?=
 =?us-ascii?Q?icoAFCWYAJwmJTC5sKO1r1MftG+s0sY4KqOXVrefprHT9f2N2/g0G5KNtIy2?=
 =?us-ascii?Q?ZiMKG+7XvZol7X5/J061ZbzuQLUy2Amh8zGKQluxvENY8P90+Wf4aNK9e+A4?=
 =?us-ascii?Q?A8UT1v6plkb5lY3ms/EaLstSWkN0zPBp+VDM2olal20LvDqzOu4/34ygs2P0?=
 =?us-ascii?Q?wIIY2dZD+iepp8XaGLiW8ju5i8EUCDKwhGn2WS5QiuoKoNrQyWpYzqv6vC8l?=
 =?us-ascii?Q?lNhXlT426F1SteQ42YX5Mw5kB6VMVhZi07nlkRkMUrIMNdaQaN8Dp7bqgk6U?=
 =?us-ascii?Q?PjbZUv82YUr/+JmchQFUiP7ishyaVn8+ttXHXS+fAOUevV3Z946cMFbwIFfD?=
 =?us-ascii?Q?2+i2pV1bgD9pS9YMGAo0KtDp35KzLpSnYBmS76xCR2o3xRvCz5+4ffQJWMj2?=
 =?us-ascii?Q?a5eMHGidG5M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsreYeHfgXtQaEx7jHU005gUsAnFAlecxs0xSHuaXEj6zMXIUQFhUUXXg7Xp?=
 =?us-ascii?Q?4le0tsx/K9MjCUpkuyxyn9OSIqQt07Vb8Itv1rmhm5dJ7EQcql+4xkwjVpOS?=
 =?us-ascii?Q?zQRN4CJ3AqsVkJseDsisXsPO0dGrLN/otKjxWqLqpt2yzTkRTUSKgHz5qQcv?=
 =?us-ascii?Q?r2P7Typ1q9YAXf9KRYTH9yLQXKryBo/VJ29T2I3FlsuztUudqoio6OUaQgSQ?=
 =?us-ascii?Q?mt8bxoMUxWNjkmClAcELObhMDHqOFE3DFOgmwWd9YrcO55DMptD8+kWWAGSj?=
 =?us-ascii?Q?wfwk2/PAFFLP7KWrUmtErtMB8zcN9BEBY8PWKEn17qj/vWCIsqX4Ck1ER2f/?=
 =?us-ascii?Q?mIAkC3yd4nGyj26z2y5JP5H/aRU+PnvjxdgSCgALqNBxzHN/UCgPZsETagqK?=
 =?us-ascii?Q?yUZDew230oAQqKOb2Pi0Y+TQJHTCq8x7eaIphf3OT9y0P35oxe5vKCuZdw29?=
 =?us-ascii?Q?2xMhA1qXsVY8Bdei3gkapytqbw2/uXkMTAMeBYafKs/V+xIitfQTCIJPRzcf?=
 =?us-ascii?Q?HH7Wfxm1cpWqRXZRbDvO1P9Eqxv1d7/nffjqN/tnjnQXLr4gywEWBLzxFizL?=
 =?us-ascii?Q?q+UJnTQWCk1Gwnj+nWVWlqZzzvw6qinuhnNn+Wz3MhTXJNsGBqzl/6r4rfzj?=
 =?us-ascii?Q?Vih2pZyVQlIuqytZux1VIYLtwV/pmGbRaW6eIPJNOY/6TYNRlE0qsmqNjS0e?=
 =?us-ascii?Q?NNkfNCKKiFcwSXgsIdqQ6QZwPrqo13mDKvONkcaQ5ZV0Bo+48OticrYoDfCZ?=
 =?us-ascii?Q?7TlOIU07RVc/9fiCKUpgaTQDl5tNO5k20z7vrHqIedWP0jhDakUlGmnSoSnN?=
 =?us-ascii?Q?wKnlI1RH7yVxxpaDM3w4yqvtkS7mLbCTRfhAeEcYKySYw9Gq5sbvDtrevjWd?=
 =?us-ascii?Q?0N5AScdUIV0FEB1QisIvi0m5jh6/5oc7D6hosEOWFGcKGyT39KeFKk9BWhW6?=
 =?us-ascii?Q?ANdWJAiBLYhwXQPtsoJ8vwZL0iyDTJoU39KzLzUfaK/V2ouA6hWhUJrvPEav?=
 =?us-ascii?Q?LrK4C9J5liIDr8Q2Sc4/FTcwv7yzQqJhrWgwDB0p19YdZLmB8R3BbWR7qeRz?=
 =?us-ascii?Q?lcFRkt7Fp09dMDv2vmvWguPPkpMKWf0sXz2m/3cobhz1RV5cMqy1C2ZUNSu+?=
 =?us-ascii?Q?P7Ib5gtgUi+bOHjZzmzic+SiE8pnB6QqXVXFzAMMtrDsNrE9wztxRsAx8OPL?=
 =?us-ascii?Q?3UXsHePTjy+OStecgZPvchtJ0erDvGWLyGj7mb7Qd1gUiOtT4KB+Kn2TOk79?=
 =?us-ascii?Q?z23Ie4zOzMt8WWoYEcBML6lHiMUBwI8ZYhwA0Dd1e0+hMzDLkqkw7kFI3yFn?=
 =?us-ascii?Q?NFRVlXfMgsd3fjNYqZFxsdZRy4kTXN9WGp//eYaZZPNictsKF7JcEx6fYzEw?=
 =?us-ascii?Q?vjORgGIlFzdDSUhNlp+aw1kzbFL7LWySaSHEEL+aqb3hXrDsEtIcIkVyyKCp?=
 =?us-ascii?Q?v1XqYJV+pMBsTKKCq6c2O+AiS5B5bhVtGIFkuvqROUIw1ejILgQmz5MqzRz4?=
 =?us-ascii?Q?kgaoVTBRzE8zg0UWAJTNEzBmo3HFwBvwk2Ivdmt1Q/1XilEBZkZtu/T9vWBt?=
 =?us-ascii?Q?eG3qp9AWu2zTI8qCOAubwA+st4+4GCohMjBu9YRz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55766add-0e3e-4001-b36c-08ddb430bb2d
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:39:14.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUQfPP4Sr4akjn15kamdpAhcb1py66dZuI1wa6R/VmrEIgVeaN/HjDsVzmAkawKa5K5i1s6OgtwiSDZ0mvhuIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7506
X-OriginatorOrg: intel.com

Colin Ian King wrote:
> In the case where a request_mem_region call fails and pointer r is null
> the error exit path via label 'out' will check for a non-null pointer
> p and try to iounmap it. However, pointer p has not been assigned a
> value at this point, so it may potentially contain any garbage value.
> Fix this by ensuring pointer p is initialized to NULL.
> 
> Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warnings")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/acpi/apei/einj-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 7930acd1d3f3..fc801587df8e 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -401,7 +401,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  	u32 table_size;
>  	int rc = -EIO;
>  	struct acpi_generic_address *trigger_param_region = NULL;
> -	struct acpi_einj_trigger __iomem *p;
> +	struct acpi_einj_trigger __iomem *p = NULL;

Apparently my review of these was pretty weak...  :-/

That said; Why not skip a goto as well?

Ira

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index d6d7e36e3647..fae01795e7f6 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -410,7 +410,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
                       (unsigned long long)trigger_paddr,
                       (unsigned long long)trigger_paddr +
                            sizeof(trigger_tab) - 1);
-               goto out;
+               return -EIO;
        }
        p = ioremap_cache(trigger_paddr, sizeof(*p));
        if (!p) {
@@ -502,7 +502,6 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
                           table_size - sizeof(trigger_tab));
 out_rel_header:
        release_mem_region(trigger_paddr, sizeof(trigger_tab));
-out:
        if (p)
                iounmap(p);
 

