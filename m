Return-Path: <linux-acpi+bounces-11027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC0A31266
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15A63A4E05
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE267262160;
	Tue, 11 Feb 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ex0T+w0W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651624E4C2;
	Tue, 11 Feb 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739293550; cv=fail; b=k9qYmfjjerqcgbrmwD2dK1Td+BEWBZz2fpUgCFbC/hSWTu/caAEzWFuFQDfVoLfaXax3o5om8ObVkXv4ue2vz1zsg0xfj2bFqzqOrogFc8lqqtZX9oDWUIsTsky3ON6JG9ZJPSDt5UyQGSHfJVjpgMUYSgsq4hLsJXovcuGUAwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739293550; c=relaxed/simple;
	bh=ZlhqkMw2DgQ3H+4Uum1RheO2qMP/XDe58kIuwhjSGBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CUv3XAa1eXSWM4Y32BAkqHoDNot9J4M/sdFWfn6ctGEOsTBoXcwrysgoiN+fAmBxXVsMe/mFi3uOi6ZRCPAExJi9nhd0d+aQbHmFh9/we0QDFhfC2bbETAaAHmflpULZKgBxjIKVC/o3iH4XQYzSSdwgoSsw60r3xbrBWJkmvfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ex0T+w0W; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739293549; x=1770829549;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZlhqkMw2DgQ3H+4Uum1RheO2qMP/XDe58kIuwhjSGBY=;
  b=Ex0T+w0W25TqCl+vcBlH1XXMYWMRboaTp6GOsjVrnLSCJ6hxW5ucDvKN
   X35z3zVVEIGBAIrRqyMkZnBt7Nr72FqmXaQMXtPOonauieHgXfcaVHX3A
   lSwkOXAKSSGsJ6RRVc3TjZyWzKOYexFT53r3rgKugG6Idef4toIjc26bs
   wZL4u+NJttWvBG8iKuiQ5His9AcxKwm5hmL6tYztvHrO+n2MTXjrPtmXM
   AYP/QEGj4NEPtOaofioz6yE+TVdisPXEZY6YmREFU2NGSco8IkhHh5O3B
   D9Ky3ZWskhy/kBmSvcTeKvVkvgSpOAC+RHCBL1IhQNOcrMWy5r6aA6Yye
   A==;
X-CSE-ConnectionGUID: 2bBcV/VPQeSXuqwJMQjtuQ==
X-CSE-MsgGUID: 0vNd/wQIQEeHO+kgMZp00w==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="65278914"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="65278914"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:04:09 -0800
X-CSE-ConnectionGUID: p9Ev+3wpQUOc0AzZQG1omw==
X-CSE-MsgGUID: /fyA0oQuQTmSabn8Yc6QAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117496257"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Feb 2025 09:04:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Feb 2025 09:04:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 11 Feb 2025 09:04:03 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Feb 2025 09:02:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNAXtxbi8XADpny1637A83F6fpNgpIvk69O/TLK2q8X97sp995NwdsRRLHrL0ExB002WWp4DI8ne9XG4QLgHWXK0y9eCWXlM3XHp4CjsSUm3RJ4V8zYZFa+w7JgmqSLnUzyy8yEP6P+bjLtR3OIUKaXBdsoQuFNHICiFVSSIncmSPuRFtgqiwQdUn/L0u0tUb/xenAQIm5ZZDZVGzpugtGszg0Exz75fuSXbs5Mc7nWeSMduKfajplXeDmchSMFJLh+6C7xD/wQdhYdsOS1ybwQVFkkWVLql56LyBn7Z9dHb4zWGwQ4vojlEQdgfKRyIcKotDq8Mfp/PfN5N3zvSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVyJ9rW9l/IPxRgAz4zvUTeZqIUDxmKG4lrjZuIKAhw=;
 b=KZwO421J+CJMhTgcatW9SvR5MGZmKAUwYINW2I0NzcuCf2sF1AWvtOX5Cmfwphd7/X2H6PQ4HvkecDy+Y5YKIL5/QJi6QIWlF0NflGs1lgYJ2IBCoAbMzuj4bGsRb1HurGHN2SthlYOAcBswUi2BOAQwdkTLii+R39FdFcmqtR9HUNt5miS+w9tXfKJOgr67KGdGox1yxFzce2hr+1kqvBaAhd0InnulpjGGp278DXgsT7ADp+8ieFb/24vf/hzmImdMs666S3saFQGBkXy8fcFlPXANu3J20nUrnmddJ9fEhSFegU+K7PWEoTQDDzF/pSMJrC+kXyaJC8wflimmVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB6792.namprd11.prod.outlook.com (2603:10b6:a03:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 17:02:11 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 17:02:11 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J"
	<rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "David
 Hildenbrand" <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, "Danilo
 Krummrich" <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Thread-Topic: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
Thread-Index: AQHbfACE0Yu2SiLzv0qtSfoPrdz0Y7NBqsKAgACpUNA=
Date: Tue, 11 Feb 2025 17:02:11 +0000
Message-ID: <SJ1PR11MB6083BF8F07A18FEF581DAAF2FCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
 <2025021111-deepen-landing-4252@gregkh>
In-Reply-To: <2025021111-deepen-landing-4252@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB6792:EE_
x-ms-office365-filtering-correlation-id: 958bf1f5-6399-4e97-e798-08dd4abdd3b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?f+v6pgi2dY77WsISvNAFUb0nolVpW+w0CFkPj0sehBoXycD04ObEeFucJBQf?=
 =?us-ascii?Q?gxckYiU5MBH9oDHRnjyi+MOvDdrlPp8t2oFnQuX6SFbHXT+LDQxovKKDONO0?=
 =?us-ascii?Q?rduHyHJ/wZdi6XC09Uk1LO7PQMDZDQQiIqED+hjbxKqfTQV4dL+HPjIu2BaF?=
 =?us-ascii?Q?9FiroAvTSK90RGfK2cipQF8BKn7elfc/+Z/W1bf4U7EVun+hP7eSvp/0okak?=
 =?us-ascii?Q?+epH98feIEZrwIzgnfkHIuVj4EWCbQq1mJFzmmKHXBSdgEa9ckdonHkPOEXU?=
 =?us-ascii?Q?dj/Su1DkROjNQV1kdd6wIpyNXRM66d14PZZscmrMwo0yUFeE9IpIsi/hbj3I?=
 =?us-ascii?Q?1eiUMFUfx5wZzhf36c+YmTStcMly5dIl3Vy0VJqzNAfQk3zyddgu/pKynr5Y?=
 =?us-ascii?Q?MK9MaV3GOb2rlICyRsyRPEAhJZdyrcE4AFfdU4e9WROKNqGFOiFzOACV2SX4?=
 =?us-ascii?Q?g9jR2vaK2Tv6QTQWXT2QQms6Y0ngX8W5HKcoULdwzXuTQD8KgdXnto7hvorS?=
 =?us-ascii?Q?CG/+/VfMfdLzWNYHisS866yD4jeSDECOUn7ozcDpwsgX5afxmis+W8+WfbYg?=
 =?us-ascii?Q?W8Bu5YbaNeGcn5tKp+g0bVJo1CAfl0vtXtZey6xp9ZTee6QDL4J5sCSmgbmg?=
 =?us-ascii?Q?U4PiAoj9LQPmu5avbTjCNy7q2C/mCx48CLhzipCwuUZkWBfXGe1tGcSfJrcU?=
 =?us-ascii?Q?x7W5SC5FqhbYBGwgcl1Fa358PSaHlQdqXkmOw0shKXNjCdoCtPNBLN/a8MYp?=
 =?us-ascii?Q?W2r2ND9TBg4vV3yPs1KHHci6O4IiGq3Wc5DcDAKfTCd2wwMzc+IqLvLrwcoI?=
 =?us-ascii?Q?IABSczn3Txs4LLKbYCh93fVsHLHnPj02a6FvA+mJtHBXMugPk5zYIDAN9pvS?=
 =?us-ascii?Q?aiU5YDpLvhTzDRQhWpgVChnuap/LdbR1eUVyTnJMJwQUa2jcatJi7JMo9YCn?=
 =?us-ascii?Q?iXmFXaljpbREKU24QZkDJleFSnhOewtS4tPPPIffY2+edkh9O78X0pXsBM+1?=
 =?us-ascii?Q?JC8NbGgzT/9t1NNBO7+6kC2yXqCX3j6i+atslua/TpISIjFkr9Ka7yA/GBn0?=
 =?us-ascii?Q?FHBps9doP8338/FR0c8sTomeg7+RJR4fRF9qmOwkwjgta+6tQvJjdzCCzNRQ?=
 =?us-ascii?Q?SPIy+NOUQmoDys+y5mssey+2k3zix/RF4L1DU26GyxedbYsfEDr+BXGJNi9t?=
 =?us-ascii?Q?j9MWXIeryUWbZqttJ8rlhyAaiyJEvBkyW5XFhFnXEbp850Henv0oo7eY4b7N?=
 =?us-ascii?Q?0MvOT6Fj66jjGB3+E6jF80QaXPTAxSv5gM59uoP40BdxWaV/nc//ty21Upfc?=
 =?us-ascii?Q?0Ko3Jz5QrSlbChRXrJHyHzLlDWCrTlKWR9juD2bgbOckogpRI5NR3YDXsePf?=
 =?us-ascii?Q?wye/hrR+9TT84koKK9U1d0hj+MCeeXGSIWjwUiZ95f7m0xqNNuW56olBO0rt?=
 =?us-ascii?Q?vXLDPs64XY7rmFam9CtWE6YroPOeI3+p?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eDxsJaNdL76N9+Z0Iq6Ih9h0eDy/PL8Lug8+7gRaoxSkvpaRNXB9YW26k7jr?=
 =?us-ascii?Q?YL5keZ/L4pjUjapxa9pmgXa4P7rQ7/vf1z4Ooc0ritZ7KLrRhqlxkWd+++ps?=
 =?us-ascii?Q?jABW2/3H5qri+AEjiNZQ5WZyUEeyIhl/9uNX8ly91M4TZAMOw9F5cA3e3cq1?=
 =?us-ascii?Q?fXA9hTcdUITSystG4cB4z2h/FPxogGjzVleQaBU03ekPS8m6dPVWhWy9zsEG?=
 =?us-ascii?Q?eUP71nMp7OmCDY7pqUJjn+hyezmfyP3JzRBI15q3vmVuenVpPQ2xTSFmiFXv?=
 =?us-ascii?Q?Msw34rMSou5iEsmd4fn0Rc3cwHIKuy/7GIwH3CCJCoENdb0sDqi75w3a4Oce?=
 =?us-ascii?Q?45sOMDD5/lep3BOm7/2cGkmTjESzwiI4CVaEp7OTXoIxjU0Y6jf1Ws7Jm3Wb?=
 =?us-ascii?Q?O3zsOPryeUTOq3cZyxAwcex1c/5uW4grOG4afGxsbw0XOCfcb1zmEsFYiWUv?=
 =?us-ascii?Q?I6vsYbC7FtK6bZDHKovdvTZAVQDCQsNPaICk56z524Ybj58vXp+HGxyxl9eC?=
 =?us-ascii?Q?OLMIuxp9/tsYhOuAaRp2ABQ1vdNtiZM00A7bU+HESDjHbFlFtbnAoaIQIGYO?=
 =?us-ascii?Q?Or6kXQxZDdmMiRmE6Nd5s5Zy4kPEOmQrUqOTt+ER4e0TgL/bWzLr278pZi2m?=
 =?us-ascii?Q?2A/TPYLSj73peujx9OcDUe3v+c1I9W0KJNo7c0uQd9Fa2y6tq3FpdoVW6y/s?=
 =?us-ascii?Q?te/9MH1SmhDY5emr2jlhX6H/cEgKUEKft3uL8PviAM7fRB942z20HvszlkEy?=
 =?us-ascii?Q?gFUgkbJIkCqC08evHJnT0sZt0uLF0nGXHH21LT6D7QPB198F1klnk4M/I2yC?=
 =?us-ascii?Q?KwDLj/lTV1Sk8UfSUZyF8t4EbBf4S3padw2kq7tG8JWSeE0MN2jILMZU3rYd?=
 =?us-ascii?Q?DGcc554aMUXogcFM3hfiJKChmXtd2ObVPENZ+CSrflAo6+9lKP/olPcn3D/D?=
 =?us-ascii?Q?KIFz7Yswu5I6sRelkTP+EoeRNktneLHZchuP8/DFMA4v1Z0CAvbSIUMUFrNU?=
 =?us-ascii?Q?FeQ6EfkARPJ3rqObcAw3I2Bi9NogNo60RbhTQ/nM2RqjB/Z6buETi0kG0E56?=
 =?us-ascii?Q?TlEUFUCzPS4jegYnQG4xD1rfUGFjCB+tnu9ICqlfuvDk+fsDMLoTb47nIagk?=
 =?us-ascii?Q?nn0tYYUa4bME15zCrIL/5oc5sn7QiHMLj9qNEv8HBIYwqCGXPGvNmMXwii0a?=
 =?us-ascii?Q?0oeI6OyApl9PuJhaFE/AE79bfRjMBOVHI4r2N9Bl0R74FwS52JKGUaypafi3?=
 =?us-ascii?Q?9kz4HEoGA0LCtoBrb8tpDmuU15wi4FtC1xPzNRLy3I2vsWSIW4GchOXXDzJe?=
 =?us-ascii?Q?rvjGPpEx4XAPh94V17v0tUCEd0KZhLwl96AaVy6o5Se/YC0ZZ5YWrIx35c16?=
 =?us-ascii?Q?7ywjnjkNu9+lMcJRNTS+UYBI2UL24Qp+XF5zWV6FJCwsxR8+p5BPsGs9g/wU?=
 =?us-ascii?Q?c1H5EkveVbAx535o3v8UjYiJRWuWzsSG3zaTdcnct4PGeE+vM5SSi1etEk4G?=
 =?us-ascii?Q?k7PHUzX+uWRGkM6HLkmJT1P5mfnolEVbYBSGe7wmhUrhwb2ttdu3XBAAKARz?=
 =?us-ascii?Q?4y6BgGMW8IRKEnvOgIZqtVUxeekaEehpf8zzaF5U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958bf1f5-6399-4e97-e798-08dd4abdd3b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 17:02:11.6780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEPBxhyGDYrTJIBfYPA2SVYQ8/LP8DSSy4in2YNh58BbTSZBwM1DVbvf3D1VXJv65KE+oNWSb8/xqjU05UM20g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6792
X-OriginatorOrg: intel.com

>> +	if (node)
>> +		ret =3D sysfs_create_link(&entry->dev.kobj, &node->dev.kobj, "node");
>
> What is going to remove this symlink if the memory goes away?  Or do
> these never get removed?

There's currently no method for runtime changes to these memory ranges. The=
y
are described by a static ACPI table.  I need to poke the folks that came u=
p
with this to ask how memory hotplug will be handled (since CXL seems to be
making that fashionable again).

> symlinks in sysfs created like this always worry me.  What is going to
> use it?

<hand waves>User space tools that want to understand what the "per-region"
monitoring and control features are actually operating on.</hand waves>

-Tony

