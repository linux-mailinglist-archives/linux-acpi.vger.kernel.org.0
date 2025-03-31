Return-Path: <linux-acpi+bounces-12548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FEA76040
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 09:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6423A84EF
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 07:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2F1C84A8;
	Mon, 31 Mar 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TljVmIIm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BC71BD9DD;
	Mon, 31 Mar 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743406721; cv=fail; b=XifSfCINU01+Jqtn7xTltpGMQuYXNObzz4wUBJ8jMnBtQZV0zIS3N3SJeflZOroF4XqkZt7ib4SU9t6rBnsBGZ3LQRNZR5ieEj9bgAEe+/rasQTcns7EQ5/juiIOn8LZYBXYcnnKhk6oorZlA3P/yGz54aj6CrYl8EzYjo5AbvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743406721; c=relaxed/simple;
	bh=/N5zwH+LdcTTXy9v1z+eVeEs6JudO6JrUdARMsLRerI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WqdBofd0GUQx4Ztzyv76KtefpooFVnaIKqm2R6uuazoNrBX+YNaOHBZ4RKpHLqfxNbD2t4ertjKHDrNGhRYr/F6DbUGQApjdP0NFGOQwwUTgQKLyOgDQLuUWERLF+hy9cT6STkM5gB7p7U41ZeIj/c7puVWF3m40Hr77TI0eUKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TljVmIIm; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743406719; x=1774942719;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/N5zwH+LdcTTXy9v1z+eVeEs6JudO6JrUdARMsLRerI=;
  b=TljVmIImvK3DgXmVhke9qQH6euW4CBq8+i6pvhkenLCfqt/j4ianz1v8
   YN8lbChlj8MKZzRsFaWWCvPgIN6l6k5AYuX28ZI1NKyBwI94QM/WFG8qd
   LWr+qm1i4OF3Tl5uE0Fh8OPt1xlXhE3RoHgwaC5LX4ZQbOcmk12voOu+a
   LTB5jest5Nc4wzsgjI/X6ao1CzmLPTIh1xrV2ALIUkM6tW70k+m6ipfGj
   YhI2kfhegq0/GwCyUBMN80dZAfUlhHeM23Tlih3hqFkUta2D7i0G3Ucms
   JSt7TIQ85erSUx5Kk37OOFLGfbr3Rrzrdzl6UIdVehgnVbAFzdTUrDBjg
   w==;
X-CSE-ConnectionGUID: Egz8XzrbQQq69v5t+CLR+A==
X-CSE-MsgGUID: FnBoSExETo+3+XQkNeJbfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="62216379"
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="62216379"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:38:38 -0700
X-CSE-ConnectionGUID: 9c3V5266TuWWE0QyfNKRtA==
X-CSE-MsgGUID: hyLBpaUISCmrlSrCAdE5yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,290,1736841600"; 
   d="scan'208";a="163258496"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 00:38:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 31 Mar 2025 00:38:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 31 Mar 2025 00:38:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 31 Mar 2025 00:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waFEqWB0+nqm1MM3ayLwrxvl+2W7o0NKrMrUlak7etDa3rHTGNGk0qcgyM8Z/4msSTPdl+bA6gDgddNI5PEkhJsUyZh7yXA4Xp7NWG8RESIEfSM6RtnnJWFLLaKjLPDKhgkPbwMNHmpGCXgNO5Ac4G6j0HUeSv/170xsY9l2ksWQELr8yqEUEyzDLgFp5v2l7Hud9Ye4b8z2NsBAHRda80Ynq0yt/xbuvaRfifLo2egZQC/9eM0pI6JhWX4Hg9pIi6fHoTv2+AGk3Q8wN9v6eUt9awU7ITzo+aoILRr215eHTFeZZDzn1IZ3OheOm3OdeenZaORMYH3vxPtsjj7GFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPeTIeFMSVDs1c12sbdva9PuJ+WfsPlY/gJT3cFXV7w=;
 b=EYTX1ozNsV55muHW1gVOvXV8Tlzh1GX/5Zmq8xvy86vdj8kXWZZNRFUKE9uKRqFYs2/limQgW31aU55Hehj2AEheOH3Y/YiHXb9PC6g4M9520n2I23k9yIjXTQFjAToO+EF2OTXBIRejXbEzKngUKEj3940RCvxHSTB4h5ft2FdEO2mOoIYr5YEWxD6aoEqP/Q6sWGhTPAXa/U+dIxPjfxcJuB4+DwzVybjjmHLyaIbKjH/peZ2yu4lKfers0yXSB8Y8hCCrdg3miwxEdcyRWPyONEj1v6iUJg3bT3vDG9X/LERMNUTzpuWiLt6EtxjJI1zqDZH+TgI+TaFy8MJdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Mon, 31 Mar
 2025 07:38:35 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::727d:4413:2b65:8b3d%3]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 07:38:35 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: Giovanni Gherdovich <ggherdovich@suse.cz>, "Rafael J . Wysocki"
	<rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
Subject: RE: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Topic: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
Thread-Index: AQHbn+4UZ+9FL9Dg6U2jNOmvmyjByLOM35Cw
Date: Mon, 31 Mar 2025 07:38:35 +0000
Message-ID: <SJ0PR11MB66228319834B1C7B48FCE52EF5AD2@SJ0PR11MB6622.namprd11.prod.outlook.com>
References: <20250328143040.9348-1-ggherdovich@suse.cz>
 <20250328143040.9348-2-ggherdovich@suse.cz>
In-Reply-To: <20250328143040.9348-2-ggherdovich@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|SJ2PR11MB7618:EE_
x-ms-office365-filtering-correlation-id: 5f67c343-f95d-42de-9c82-08dd70270b85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?dHaA8OD/Bux7mIk/VAKaQ1U5Fc2jzYhultQAHHKVoZHMNxJYKKkiBd0a8fGt?=
 =?us-ascii?Q?LoUB3dJrJOBsiJCq8ryFaH7i5PZJdB9SMiHi7cbA6d71JkdfzKXu0T2xIDXZ?=
 =?us-ascii?Q?01FlFPCxSr9jVsuuogiNHeuCceT6sszlFsJK/XeXfFJ9M0/5KfRvFO0dZhNT?=
 =?us-ascii?Q?70Rz1CuZh/43LqEw5rsCEeL2z1jI9NzBE+jirlxspX8oaJZEDiirxKXkFV2b?=
 =?us-ascii?Q?hl/sKQSFkYXnW/b3i89MoryE590I+XjyPpHeK9cKyqyiX44FVnKa/ofvp+h1?=
 =?us-ascii?Q?gf0resqCO2PnzPceezCP2tO+es6f3oALGDYyNHAZVIESjKfezF5eRm/4kX3o?=
 =?us-ascii?Q?PF9C4BOKP7fallX7x3b9q2qduVSwGTw4+R6SdMY+7PNXb4kbU0N3PC2zKWNF?=
 =?us-ascii?Q?E4UgAL3koEs29TF4xvO+djwJQydpUHN/9hv/resP5GmlHOYbVWxZTRb9uQa1?=
 =?us-ascii?Q?l5rNNejw5+bSTgh/rv9gn7JbzdNkStgxmzQi69c9Bsv/tNcz8P6UyBrWkydc?=
 =?us-ascii?Q?xHf7Mkw7gxVoyL98WNtO857cC5Cb7r/Qj7Zp4jQgUAV1GikV8KUyL1DxacYW?=
 =?us-ascii?Q?Pycw10bDimbKBvaFwZj0Lop06EqoXdtWMc4U9WeCGVPTBV/vm2lr+Mz2UEiW?=
 =?us-ascii?Q?OHAM3PIIg47VjFK/lZxiBwtZ84Tm742h7ImI8vA48QBNzXOWI3AuGDVUm+J6?=
 =?us-ascii?Q?x4epGZt7CAMC3+HHyQjzr+kSuw4+MCv5EeZ22Uhi7fi61nGQOkc2Vksw0c0B?=
 =?us-ascii?Q?urK6MvjrqbpvqePXer5RoDwvns0QYd1uYJ1/cIUBcg44tFSZeknpGNO9sedF?=
 =?us-ascii?Q?JAX8EMhOWVsxOkkKlRdOLU0eQh5pnKUEkmsKce22iS8tEiXDiU5mkRIpKvx+?=
 =?us-ascii?Q?WURd4ebU1A3xQtuqfJGios+kgUMsLwnkYFIaF2ULuEkIA9nGtfuHoM7/lWTJ?=
 =?us-ascii?Q?MOkz8Fgc+Fuw5lX5y0ymZ9/XM8yOHugqa2ke/DDC/wxLr3+4n73UPC/9PbZn?=
 =?us-ascii?Q?U+Map7wj99cbw8a2KES8RH/mg0pE52Q6hHRvpXIfMrsRkcUrGQjCMZAjGdeV?=
 =?us-ascii?Q?4HYtvbQ1fWgIwYSUaErsoU0l6y2fOjAmTZXYpShElHRcxyUMNpfi+h5R+fXS?=
 =?us-ascii?Q?m+QQ41VJLrHx3TgXx3rbXv1+GLWE3f+6EwkxDZJ6URV3iNq4sssPc0H+Z04k?=
 =?us-ascii?Q?sQvhWgDqQcZnxkkQLQrVnsishWShPsDMxb9rn3b7EUzfcnrkK5AsW6KC5tYL?=
 =?us-ascii?Q?DvTxo8hu9BsLt7L9N3/edatH9BCqjMSPZNzST8t7cdcxG/iicXzfzTJm0vKu?=
 =?us-ascii?Q?jOGcEvHFHk4Qm6u/RGvkZM7PsbsYnshJ6zBIhjcUywE14npSg+D7OP7pmIzK?=
 =?us-ascii?Q?8qk57XAucDo2dpuWWZTsaMiuEtCieSrXdHZvTWITBX2AvePAXuaAXLUuHHcp?=
 =?us-ascii?Q?VHeZJj1iyHYFfiKHQ/sBAnX7hB7dEIG7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iejDV35A8tVIPa4U/Yx1OuP6TtO394aQQ7O+6Yc7XPLQDqozHvUIAjDX7iHA?=
 =?us-ascii?Q?5L+CRgL/XZApeia4rcIGeM79Md2MvWNqr+Fcq2MtadVscMVqdWiGK+oOjCXm?=
 =?us-ascii?Q?HNW0R+Xk53sgqroKXfflDAhzlovLsGZrX+2FnuRoPutzYM2iVZ1zsV+u1wQw?=
 =?us-ascii?Q?Dgsa57mi25jOeww1oYpAzu0e6oEjorDPKOXXD8xYtvR+2L3JkR+1lA1aiaeN?=
 =?us-ascii?Q?NdeKN+mPSpi72a7AxjTqiLF0/k6f4Zxbr3Hxr+Ow5kace28h9uayMIvqpeeL?=
 =?us-ascii?Q?5JWX7qJwn/Ap37Cop5NpZwpK+1VWoC+DHfI7FIVsei+mTa0Cj1Mvh0FGmK43?=
 =?us-ascii?Q?qP5jiWlrFmFNrcQTCyUu6WvP9/ghssm9T13za3HRuVOM/lHyQCwhsm9PeQcF?=
 =?us-ascii?Q?tpLozLB6/JvGMT7XhFTF1dY8JIix/aALUSEoC5JmXv27b5U1xra0ugWepBQ5?=
 =?us-ascii?Q?TFTVKHTKnmWK9hxrTH7hwSvi0C5kQLKZwsu9wswyL46XNlgqNhsESuqpMZmZ?=
 =?us-ascii?Q?OLuiS5D5c0lmNU7RAbu25kBTEZ7KtzucvGsEwtIwACX13Kr3BcVCvVxQiMcg?=
 =?us-ascii?Q?1nTqud6dI357EG7XDUZnGFI9R+K73oI5nZlG7meZOMaGDF4TGOMtrIYYdB96?=
 =?us-ascii?Q?gTIac7OSUxYyLHYFFlPWpi9MQlRrHBwuZ4rFe5eRFWd5w8PN3aJRLmWz20MH?=
 =?us-ascii?Q?tiVs4+nO66CGXQb2FrEAwVSMT/j9Rb/dy7A7EIQntkaTL1vwxJ1UBvQU1dE9?=
 =?us-ascii?Q?KE6YwcHuJhm8qIRZYV358x3qVQR2YKD3R9gHA+Z0W5Rj5Ll0HfPHxc5gRYWR?=
 =?us-ascii?Q?Ysvgmmdx8Io6oNQvEi0XTS7AVj8L8d22Cy1WU5UqpHF4FQljeQL1VwzMxEGA?=
 =?us-ascii?Q?25JQJfFh9/u3ddanzNwzYU0iRjxBM0DbDB9kTXUU5Z4Zz2dZKpUQwKg4xRi3?=
 =?us-ascii?Q?kE0xf7zhKvKVgcHmXM0kRot7AuNtzoNzBy0nb7pIEyUBNCzvd50o4kk6eBsC?=
 =?us-ascii?Q?CT/+cSSs3iaxYV2q21Xwtmyp0rovt8RvkJg+9ebWSdNrO7JZmHFEiA7afm6U?=
 =?us-ascii?Q?2a3Pl5P13MHLNOsxnF2w18+dKUYiCGoxllm0RG9z3t19ss/du6bttG8jIXGE?=
 =?us-ascii?Q?ndlksaYggmss+WUVIADIoblldI4Htji1iZNsGyAOLwQYuVCrN04Na7d+DTUl?=
 =?us-ascii?Q?C3RhFsoN/6RGqBGOjDv/wFFOBG4Y+vFDMiKgmSlDIfcXlIQhJxDZVkdgH4Hv?=
 =?us-ascii?Q?U8LNZZHXDJv6NkF+8YpUqQB0PXFPYYltmzfAw9g0tMLPuoSwSIMxhL61rklU?=
 =?us-ascii?Q?67pOg+IGGSgpOkWGzY0PDDMvMJI1r/L19TKHimNNVNATLV78GFyaFVuQZzzW?=
 =?us-ascii?Q?/dx0vW6nHtyI0cNnug/UYkiRswxsYbzHbuCABNFbUWo9fR13rag7Mm9oQR3w?=
 =?us-ascii?Q?nRcnHf3zTgZsRjx4ZS1Mn3ShjyQ81aY9NJsamaBO3oNVTN8zhwAswluz2AM7?=
 =?us-ascii?Q?0B6h3xr+rWIyvXcRIawMy1EGtD4CHYTUsLLc/pj5QNLBx9CpUKilMjdFps0h?=
 =?us-ascii?Q?Wpt4PBL+ZFI4QAwl6CqAcOaedmS+Lz+PG4bCO0gg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f67c343-f95d-42de-9c82-08dd70270b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2025 07:38:35.5413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJOvOhVEEH7zQWdru6oowt0IzmXZj3QLdqQW/ag4SCOXBDAgJiiJoG022TmO2vSDDVSPa7YnsSerOqTE7rXITg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Giovanni Gherdovich <ggherdovich@suse.cz>
> Sent: Friday, March 28, 2025 10:31 PM
> To: Rafael J . Wysocki <rafael@kernel.org>; Zhang, Rui <rui.zhang@intel.c=
om>
> Cc: Len Brown <lenb@kernel.org>; Giovanni Gherdovich
> <ggherdovich@suse.cz>; linux-acpi@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pm@vger.kernel.org
> Subject: [PATCH 2/2] ACPI: processor: idle: Remove obsolete comment
> Importance: High
>=20
> Since commit 496121c02127e9c460b436244c38260b044cc45a ("ACPI:
> processor:
> idle: Allow probing on platforms with one ACPI C-state"), the comment
> doesn't reflect the code anymore; remove it.
>=20
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
>  drivers/acpi/processor_idle.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index b181f7fc2090..2a076c7a825a 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -482,10 +482,6 @@ static int acpi_processor_get_cstate_info(struct
> acpi_processor *pr)
>=20
>  	pr->power.count =3D acpi_processor_power_verify(pr);
>=20
> -	/*
> -	 * if one state of type C2 or C3 is available, mark this
> -	 * CPU as being "idle manageable"
> -	 */
>  	for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
>  		if (pr->power.states[i].valid) {
>  			pr->power.count =3D i;
> --
> 2.43.0

I think we can clean up a bit more. How about the patch below?

From 115d3a07febff32eed49f9343ef111e7e1452f9d Mon Sep 17 00:00:00 2001
From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Mon, 31 Mar 2025 07:29:57 +0000
Subject: [PATCH] ACPI: processor: idle: Simplify
 acpi_processor_get_cstate_info() logic

Since commit 496121c02127 ("ACPI: processor: idle: Allow probing on
platforms with one ACPI C-state"), acpi_idle driver can be probed with
C1 only.

Optimize the logic for setting pr->power.count and pr->flags.power by
1. unconditionally set pr->flags.power leveraging the fact that C1 is
   always valid after acpi_processor_get_power_info_default().
2. update acpi_processor_power_verify() to return the highest valid
   C-state directly.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/processor_idle.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 698897b29de2..7ce8c3802937 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -442,7 +442,7 @@ static int acpi_processor_power_verify(struct acpi_proc=
essor *pr)
=20
 		lapic_timer_check_state(i, pr, cx);
 		tsc_check_state(cx->type);
-		working++;
+		working =3D i;
 	}
=20
 	if (buggy_latency) {
@@ -457,7 +457,6 @@ static int acpi_processor_power_verify(struct acpi_proc=
essor *pr)
=20
 static int acpi_processor_get_cstate_info(struct acpi_processor *pr)
 {
-	unsigned int i;
 	int result;
=20
=20
@@ -477,17 +476,7 @@ static int acpi_processor_get_cstate_info(struct acpi_=
processor *pr)
 	acpi_processor_get_power_info_default(pr);
=20
 	pr->power.count =3D acpi_processor_power_verify(pr);
-
-	/*
-	 * if one state of type C2 or C3 is available, mark this
-	 * CPU as being "idle manageable"
-	 */
-	for (i =3D 1; i < ACPI_PROCESSOR_MAX_POWER; i++) {
-		if (pr->power.states[i].valid) {
-			pr->power.count =3D i;
-			pr->flags.power =3D 1;
-		}
-	}
+	pr->flags.power =3D 1;
=20
 	return 0;
 }
--=20
2.43.0


