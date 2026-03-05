Return-Path: <linux-acpi+bounces-21375-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOMuChbLqGlBxQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21375-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:15:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D94B2095E5
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D54D4303F04C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9535959;
	Thu,  5 Mar 2026 00:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mULTGFgJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AE339A8;
	Thu,  5 Mar 2026 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772669699; cv=fail; b=dR9NrrnNy1lMIeavDyA779EJlvSrHfEILycHyEPCWAqrgdaVbdYJEhp+gHP/2T2FZFUSkYNnk1utn6CTPT9LhCjReaQfBcAI3s/ogiYPWRdyAa+UgjcMLtwc5ef7xm42xsaP6iQTsBG7WY6fISXAeiGsUGVgzaBpyeizdRchodg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772669699; c=relaxed/simple;
	bh=7lC8wZya/04GHrRQOh9+9dAJsuZOaDgE+1dQKYFH7Z0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quYYyzrrIczxv5imY0BGhKZQI3MjQR1TpeDCqgJZhF8dLsndadRoRg1qpDUH5siXxyvDPsJNj+ZyveA1P833Q0Bv2kNXqFZDIyEb8+L5kDP/18KN5f2QUGGiq2L+WoGfwQ0q/QRe0RL8zcuz3frH50Npd0jHNQCKnh2nMmKW1CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mULTGFgJ; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772669697; x=1804205697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7lC8wZya/04GHrRQOh9+9dAJsuZOaDgE+1dQKYFH7Z0=;
  b=mULTGFgJLD0Jqx8jez9NkcXQ29gXig3vOTOFRV8ozEHyl6woVM6t6DGV
   hiQD0prcn9fx5mzQ2omv3DBiZTInT8J54xV4uBL9JXYt1zUFOo3pjlw6k
   QRsRlY0xT2Xpztr6rH8woYAuMhY9tmwEsdQwfG56FMzLCufAif6mY2EdL
   QbDaq0utewI19JdZa7n874kMuW3TvrDUI8GeTWGTzRro5uTN0bnVJJh/E
   uHIDDgBXNXGxoD3uS/VeO9JREd8dCt+ofxGwhHu3OfvEut0+r7XY4JgM4
   0axYgstkF2roYwPAMsHWR30iy1ds4ZrSH4J+U35iTU7Mdw2d1vKpewNWo
   w==;
X-CSE-ConnectionGUID: vScX3NnTTw6vBAmocoXsSg==
X-CSE-MsgGUID: iZyEJS5fQTekBN8JXfBnoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73445062"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73445062"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:14:57 -0800
X-CSE-ConnectionGUID: v564z1NSSZGRP5u347/b2g==
X-CSE-MsgGUID: I58Fxhp/Tb6D7XvPpBtM2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215381927"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:14:56 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:14:55 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 4 Mar 2026 16:14:55 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 4 Mar 2026 16:14:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqa78+4Tn3eNpmac7+AmGGE/4xWlXphMbipOEOaaS4r9kcqT9dLhGDWyq2PnwiVTTl7YnGKIWHZ5pemcRAFbcBXDK8YAKiPrjIyiBo8jO1xabCFKob0wAM1WqRjRbJqqIoEJ721T5wqk/F/ejeGS7HF44tDB3lYCTuDXnRjUGwYDe2cEqGp6gGsbp8gQNCATZveUM5l9VASptS0DnAtu2CP4rI275Py0YVfwOuTTy7SUikvCGOEjEB1HCvue39XU8t2Bt5mB3SEIiB9bi6R0Zs97ZR1gVtOD1RvFfAHziBBiRg5NZ2wANAhjha4NCcDnyeSET7/79NLbpvoFsvvVlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lC8wZya/04GHrRQOh9+9dAJsuZOaDgE+1dQKYFH7Z0=;
 b=FQWiNG+vEvsO8UsFij+2HAe48xusvylRlaKsiQMMaQc08LguuEZZAf1UlpC9T8R1eWsUpunVppUZfS/c4mbxLVX550Whqrq3dJmIdt+wi6Qm85eLqMMc4tADLImjHjfCk290QDgAVhwY/e20OdEVobQglljKe/Gq9++zk7wwkco4OlySh6fCZOt185D3kZ4LdSOKh4mGy+kEiuCINNYHgFi1XMlVDFE1hw15lbknjBNRySz3S/10NbNHxQLSm51dOCPtNf6VaFxneZmnZwkNgMYNMatjO5pTzAGE+fa6gAv3wRR1Ys6k0x/P2o2SgiAL6zZDZQJX4nWW1yCgtiIpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2650.namprd11.prod.outlook.com (2603:10b6:5:c4::18) by
 IA4PR11MB9082.namprd11.prod.outlook.com (2603:10b6:208:56a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 00:14:52 +0000
Received: from DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86]) by DM6PR11MB2650.namprd11.prod.outlook.com
 ([fe80::ec1e:bdbd:ecd8:4c86%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 00:14:52 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Schofield, Alison" <alison.schofield@intel.com>, "gourry@gourry.net"
	<gourry@gourry.net>
CC: "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "rafael@kernel.org"
	<rafael@kernel.org>, "thorsten.blum@linux.dev" <thorsten.blum@linux.dev>,
	"wangyuquan1236@phytium.com.cn" <wangyuquan1236@phytium.com.cn>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Topic: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Thread-Index: AQHcrB6hFMt1tftCWUOUCZXHrNvLJLWe9ZgAgAAND4CAAAoyAIAABQUA
Date: Thu, 5 Mar 2026 00:14:52 +0000
Message-ID: <4809035f61dcd6ace773532efe46b0f1928be313.camel@intel.com>
References: <20260304213342.5776-1-kai.huang@intel.com>
	 <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
	 <aai-K2tEdIp5B4XP@aschofie-mobl2.lan>
	 <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
In-Reply-To: <aajGuOC-G_dFYpwa@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.56.2 (3.56.2-2.fc42) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB2650:EE_|IA4PR11MB9082:EE_
x-ms-office365-filtering-correlation-id: b9ab59d7-44ca-4a12-186a-08de7a4c38fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info: gi1tRigYc4gUGJBuROqGYF5lO9sEPs+8JYe8egjViwrD5VbEmX35kSBgHHpN5OX11zxhvKEVfflA6URWK5aCRZ8+r6Xg+5HRgq79Uw5wsaVzYnanX6MCwg4fGJwhobTenTF40v/JHEQv24SrCA9At7PK20gMAmgESh81fnxY0Zzib5Po6hAFLN7N6QuznrYBfRTHBs5YsX0YngCzvL6dR3k7/qtJKFAIaQwm+In/ETAHMbmMqhXDxe3LI5saIhfce3SH2ovnuRkQ6/isl8WuqNmFsWHQh908xb4XGMpwrn5Wmk57wLa08YqPhr6vF41u7yxbVhxEeQ3OpqKd6lbvGVumP20QjVhto4ybYTRnybaJ7Nuc5iKyMpxtT3t3gsW6v26ocmZQMapmspEx7Asttr0i8HPoOgVZcPjBYscTyJYvxymkenihTtp8z9WyqHn3kcsij1Wc3bC0KR7xCFffa+gMrg4itWgNuzrVb10sG0VZbZ9Vd1QiQHv4ZcxsxgSrfBCTaZ8dprEB2P0EDIkbNbSR0xd/U9VQ4ZQoGgc0o8AD95tu/EctB4VWoDujel80eISLldC6KUVKDfVjUklUVcfnEOKwWnFqEhcpGfWSYtdjnGdKKENLAFoOAncJ9HNFzPPx+GWqD3Zoi3Xuk0+473ye9d1Af4eE7+0o98Si5Ic5N3tEwKNfEenZVhrMMMrFG0iBJOx6bnk8LjrFOP9Vaegy8/CHI+ng+Ccv5wOp0FtQZC1wTnfT8L5/ViaiPTUEI9ohd+x/ndvh4QH/WePrNayzFzx3a2dTa2M+5xMvEkE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnBsaGdrZ3habUdmOXgxQmJ0RFo5L0lLOWhGZGVmTWdWT05IcUZDYTNHOVpQ?=
 =?utf-8?B?MXAvcjN2NVg1cWdHRjRCSDdQc2JwSnZTVFI0aG9RZG4reERnNHhUbVpucnpa?=
 =?utf-8?B?a1k3TE10ZlFCdmxML0VyR0xnbnJKNEVWdVVqeGh3QnBmKzBwaGl3aVNrWEJ6?=
 =?utf-8?B?NEFuK2hqOG04SnF2bEZWMHNrOHRlUXM4b0ZzempUbk1zRnNuU0JUZ2FnK01a?=
 =?utf-8?B?TlhyNC9Ca2ZaNHN6OEMzTnhUSjRHOXhuRTNORStvcW1acWxOdEdsMXFjdDZy?=
 =?utf-8?B?ZitWQzBKZ1FER2xNMFJCWEtYZVBjTVZTTWVFOXVsRUFUaC8ycUhBU21ZNGRK?=
 =?utf-8?B?b1lEVGNkZm5icW5sd29sMVptVDIrUkx5VnZHMUIvMy9Ic1dza1FlMzM2ZjU3?=
 =?utf-8?B?bm0xWWZIU3FVSHVXY0pUZlBuTmJYeTlYQ0kzVXc0NmZoTFdCVmIvUDJWQ1Q4?=
 =?utf-8?B?UHpNeGY0RW5Lc2FnZFZvMVk3SlRkOUhZU01BbVBhY1ZaZFdmaFdhU0ZlUGdn?=
 =?utf-8?B?VmozYlNlRWRtZ1B4OTdLeU80bXpzYkdZTmtSaC9aRmdobGlYSFZRMS92VUZn?=
 =?utf-8?B?QVZIemVWSndjcWVLWXRJOEEyVUtLd2pxclFwU3I4dE1FMm1od0twR2RqTE9Y?=
 =?utf-8?B?N2FOKzk3WlVOYmlkL2NLVjRkcCtyQ3lyYzFVbVBZTjhQblBncTFuVitXamRt?=
 =?utf-8?B?YS9hSmdGQVJndnlHM3NpTmVlTnB3Vjl1dWxlTm1JS3V3cXRQa3J1bmhISGp0?=
 =?utf-8?B?ZEQ0ZnFKNFVkenFoZE1mdFBVcDBzM1M0blRvZy9zdEFnK1B3TEM2U3FBM2tF?=
 =?utf-8?B?WUlDZ0dqU3hhRGw2U3lReHVtdzB6NlBWWlZxQ1NmYWY0bklQdlVnbnVKNmNC?=
 =?utf-8?B?c2ozQ1Jkb2VRcDh6a3hoLzFDZXRnTSsrQ29kb3R3ZkFwZWYxb3FmVklBL0Zs?=
 =?utf-8?B?TDMrRTg5QUxPd0UzSzBFQWNrbUI0OU9lclVRSS9QbEhZZWovcUNSR0RwREZU?=
 =?utf-8?B?RUpwS1cwY0JBcGk4NnRBNnRwS0YrU1o4dG1QeFc4TTNkWUJFTjREbWEyZUor?=
 =?utf-8?B?UmNIei9NSVF4SE1zSUcybmVhYjNJSjloT0ZKNGxHb01GMXl0U0hIYXQrU0Q3?=
 =?utf-8?B?ODBhT1Q5U3dKMDQ3UVdlT3ZYVGJFVnYxQkUzc3NiUVhLa0pWQ1h3czVNeHZh?=
 =?utf-8?B?b1lTN3kyM3Q5N2NRZzJ6T1VGLzNXZ3Z0SjBPazlIN205VWRrZndmZFpCT2VG?=
 =?utf-8?B?ZzAyOXllNVNERUJNWkRpZjdaUkE1NU1qeG1LRHQ3Z0VydlpmZnRvT0FZb1pz?=
 =?utf-8?B?VzdSR2RBaVFNR0NXSXJ6U2ViNnZnemEzUG5aci9IWWhFdGVPNy9NUHgyOVF3?=
 =?utf-8?B?REpna3JnN0VienRqZXhtd0NKQ0hlZW90U3Yrc2FKV3M3T01SMUMzU2Y3eWZv?=
 =?utf-8?B?amJvT0VOZDhCSWVQN2thNE5icjZtZDVkTXhFZ1BUSTNyY1N3WWlNcjFXZTlK?=
 =?utf-8?B?YzREdnNTVGpXZHFOU3FtSTVmRUFGbVB1S0swc2NOWWVMaDdDdmtpYngrZ3dr?=
 =?utf-8?B?bVFWNzVQL1ZUUTZGcGgwMld3TG1pbmN2aWlaV2RYRHY1UUE4dUw1T0tmNkVH?=
 =?utf-8?B?eU9oUXhVcjJ6VkJIY0hNdjVrL09KUTZ0My9EZ3pCVSs1R25yTUlqWkRqay9I?=
 =?utf-8?B?UGpuRmlZRHdReHg5UGJWRjc2R2NtS3lpQTRUaW1nbmFycVVTUmtqWUFWSW8v?=
 =?utf-8?B?Rnlkd09aUCtzWVV0MkhzdHNyM01QbjFSWCtvUnZEZ2FMekhDYlBIOTNPZjFp?=
 =?utf-8?B?dEFjQVVkY05tM2FaVVNEZGxheUlIUm5Wb0ZPZ0pZMTNQQ3RCekJ0V1M5RmU1?=
 =?utf-8?B?MGVickQ5QUFuYjJuMXh2MVZVVkhWTHoxSkJ2R2txVnlrZ0I4RjhJc05nZjho?=
 =?utf-8?B?MTBCMzd0NlArZEk0YjBnQUc5bUZuWFIwQ1JDMDRMcTZSbTRnUFB1UTk1VGc2?=
 =?utf-8?B?VjRSUHYzU0hFMkVrS21QNy9BMWd0ZUNEekh0czM3djI5Zm42b0dzS0l0WXR2?=
 =?utf-8?B?cjdRRWJSWVNFOHRuUVJPRDh3UnFxQkhiMWFhQWF0RjhuSGV2UDFKNE1VTlk0?=
 =?utf-8?B?MGtHT0tsMVplY0g5U2FldUNkeXdwRE93TTh6L3pwcFNpbWFoamZheENTSFV1?=
 =?utf-8?B?V29QcEo3NUFrY2dQdTIxbkNwNWlmdTFzUXdZRjJVMnNpR204UVhVOTFJMnBI?=
 =?utf-8?B?d2hpZEhrVFRiSWVDOHJXeEU5ZmhkeGlVTUh1VmtWanoyQzFQbGlEeG5mOVJ2?=
 =?utf-8?B?eTlVeTIrWXlBUXgydVhoQnk3WWdXRWdUbS8wdmR0bkFWbXh1RUxYZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32347D4A3416304DA1814AE886368D4F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ab59d7-44ca-4a12-186a-08de7a4c38fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 00:14:52.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5nHyxImdHMO2Xp7aa4jfMhK3avFw9t5j5GnXnoXnGm6pr6mRKj/EsbsAe7LMmly75w+JWsGgoJOddKETDEraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9082
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 9D94B2095E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21375-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.huang@intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

T24gV2VkLCAyMDI2LTAzLTA0IGF0IDE4OjU2IC0wNTAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOg0K
PiBPbiBXZWQsIE1hciAwNCwgMjAyNiBhdCAwMzoyMDoxMVBNIC0wODAwLCBBbGlzb24gU2Nob2Zp
ZWxkIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWFyIDA0LCAyMDI2IGF0IDA1OjMzOjI2UE0gLTA1MDAs
IEdyZWdvcnkgUHJpY2Ugd3JvdGU6DQo+ID4gPiBPbiBUaHUsIE1hciAwNSwgMjAyNiBhdCAxMDoz
Mzo0MkFNICsxMzAwLCBLYWkgSHVhbmcgd3JvdGU6DQo+ID4gPiA+IEluY3JlYXNpbmcgdGhlICdu
cl9ub2RlX2lkcycgaGFzIHNpZGUgZWZmZWN0cy4gIEZvciBpbnN0YW5jZSwgaXQgaXMNCj4gPiA+
ID4gd2lkZWx5IHVzZWQgYnkgdGhlIGtlcm5lbCBmb3IgImhpZ2hlc3QgcG9zc2libGUgTlVNQSBu
b2RlIiBiYXNlZCBtZW1vcnkNCj4gPiA+ID4gYWxsb2NhdGlvbnMuICBJdCBhbHNvIGltcGFjdHMg
dXNlcnNwYWNlIEFCSXMsIGUuZy4sIHNvbWUgTlVNQSBtZW1vcnkNCj4gPiA+ID4gcmVsYXRlZCBz
eXN0ZW0gY2FsbHMgc3VjaCBhcyAnZ2V0X21lbXBvbGljeScgd2hpY2ggcmVxdWlyZXMgJ21heG5v
ZGUnDQo+ID4gPiA+IG5vdCBiZWluZyBzbWFsbGVyIHRoYW4gdGhlICducl9ub2RlX2lkcycuDQo+
ID4gPiA+IA0KPiA+IA0KPiA+ID4gDQo+ID4gPiBJcyB0aGlzIGEgTGludXggaXNzdWUgb3IgYSBG
aXJtd2FyZSBpc3N1ZT8NCj4gPiANCj4gPiBJSVVDIEJJT1MgY3JlYXRlcyB0aGUgQ0VEVCBiYXNl
ZCBvbiB0aGUgaGFyZHdhcmUgaXQgJ3NlZXMnIGFzIHByZXNlbnQuDQo+ID4gDQo+ID4gVGhpcyBw
YXRjaCBpcyBkZXNjcmliaW5nIHRoZSBjYXNlICh3ZWlyZCBhcyBpdCBzZWVtcyB0byBtZSkgd2hl
cmUgd2UNCj4gPiB0aGVuIGJvb3QgYSBzeXN0ZW0gd2l0aCBBQ1BJIGFuZCBOVU1BIGVuYWJsZWQg
YnV0IENYTF9BQ1BJIGRpc2FibGVkLg0KPiA+IA0KPiA+IFNvLCBJIGRvbid0IHRoaW5rIHdlIGNh
biBibGFtZSBCSU9TLg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBJcyBHTlIgZXhwb3J0aW5nIG1vcmUg
Q0ZNV1MgdGhhbiBpdCBzaG91bGQ/DQo+ID4gTm90IHN1cmUgb2YgYW55IGxpbWl0cyBvbiBmbGF2
b3JzIG9mIENGTVdTJ3MgYSBCSU9TIGNhbiBvZmZlci4NCj4gPiBJZiBCSU9TIGNhbiBjYXJ2ZSBv
dXQgYSB3aW5kb3csIGl0IGNhbiBjcmVhdGUgYSBDRk1XUy4NCj4gPiBOb3QgY2xlYXIgaG93IHRo
YXQgbWF0dGVycyB0byB0aGUgaXNzdWUuDQo+ID4gDQo+ID4gPiANCj4gPiA+IElzIHlvdXIgU1JB
VCBtaXNzaW5nIGVudHJpZXMgZm9yIENGTVdTIHRoYXQgYXJlIG90aGVyd2lzZSBwcmVzZW50Pw0K
PiA+ID4gDQo+ID4gPiBBcmUgdGhlIENGTVdTIGVtcHR5PyAoaXMgdGhhdCBldmVuIHZhbGlkKQ0K
PiA+IA0KPiA+IFdoeSB0aGlzIGxpbmUgb2YgcXVlc3Rpb25pbmcgOykgIEkgc2VlIHRoZSBwcm9i
bGVtIGFzIGEgYml0IHNpbXBsZXIuDQo+ID4gV2UgaGF2ZSBvdGhlciBjb2RlIHRoYXQgdGVsbHMg
dXMgaWYgdGhlIENGTVdTJ3MgYXJlIHZhbGlkLCBldGMsIGJ1dA0KPiA+IHRoZSBwb2ludCBoZXJl
IGlzLCB3ZSBhcmUgbm90IGdvaW5nIHRvIHVzZSB0aGVzZSBDRk1XUydzIHNvIHN0b3ANCj4gPiB0
aGUgcGFyc2UgYXMgZWFybHkgYXMgcG9zc2libGUsIGxpa2UgcmlnaHQgaGVyZSBhcyBLYWkgaGFz
IGRvbmUuDQo+ID4gDQo+IA0KPiBNb3N0bHkgaSdtIHdvbmRlcmluZyBpZiB0aGlzIGlzc3VlIHNo
b3VsZCBiZSBkZWFsdCB3aXRoIGluIHRoZSBhY3BpIGNvZGUNCj4gb3IgaWYgdGhlIGlzc3VlIGlz
IHRoYXQgd2UganVzdCBkb24ndCB3YW50IHRvIGZpZ3VyZSBvdXQgaG93IHRvDQo+IGxhenktY3Jl
YXRlIHRoZXNlIHRoaW5ncyBpbnN0ZWFkIG9mIGFsd2F5cyBjcmVhdGluZyB0aGVtIGF0IF9faW5p
dC4NCj4gDQo+IGl0IGRvZXMgc2VlbSByYXRpb25hbCB0byBidWlsZCBvdXQgc3VwcG9ydCBmb3Ig
Q0VEVCBlbnRyaWVzIGlmIENYTF9BQ1BJDQo+IGlzIGJ1aWx0IG91dCwgYnV0IHRoaXMgYWxzbyBt
ZWFucyB5b3UgY2FuJ3Qgb3RoZXJ3aXNlIGxvYWQgbW9kdWxlcyB0aGF0DQo+IHdvdWxkIGhhdmUg
bWFkZSB1c2Ugb2YgdGhpcyBpbmZvcm1hdGlvbi4NCg0KQmVzaWRlcyBDWExfQUNQSSwgaXMgdGhl
cmUgYW55IG90aGVyIG1vZHVsZShzKSB0aGF0IHVzZXMgdGhpcyBpbmZvcm1hdGlvbg0KZm9yIHRo
ZXNlIENYTCBtZW1vcnkgcmVnaW9ucz8NCg0KPiANCj4gVGhpcyBiYXNpY2FsbHkgc2F5cyBpZiBz
cGVjaWZpY2FsbHkgQ1hMX0FDUEkgaXMgYnVpbHQgb3V0LCB0aGUgTlVNQQ0KPiBzdHJ1Y3R1cmUg
aXMgZm9yZXZlciBsb3N0IC0gZXZlbiB0aG91Z2ggaXQncyBhY2N1cmF0ZWx5IGRlc2NyaWJlZCBi
eQ0KPiBCSU9TLiDCoA0KPiANCg0KVGhlIG5vcm1hbCBOVU1BIGluZm8gZGVzY3JpYmVkIGluIFNS
QVQgaXMgc3RpbGwgdGhlcmUuICBJdCBvbmx5IGF2b2lkcw0KZGV0ZWN0aW5nIENGTVdTLCB3aGlj
aCBkb2Vzbid0IHByb3ZpZGUgYW55IE5VTUEgaW5mbyBhY3R1YWxseSAtLSB0aGF0J3Mgd2h5DQpr
ZXJuZWwgYXNzaWducyBhICdmYWtlZCcgTlVNQSBub2RlIGZvciBlYWNoIG9mIHRoZW0uDQoNClNv
IHdlIGFyZSBub3QgbG9zaW5nIGFueXRoaW5nIEFGQUlDVC4NCg==

