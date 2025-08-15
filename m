Return-Path: <linux-acpi+bounces-15736-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62091B2834B
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 17:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC8D3A1446
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Aug 2025 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DB308F19;
	Fri, 15 Aug 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T60rX+/8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F338DDB;
	Fri, 15 Aug 2025 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273113; cv=fail; b=lFqNb8vv8zUWUTLlW5pG3MY2KOP6AOYVTand4AqM7v14EV7vmJdqaf2xckpMu8xNlRwIodqgxM2rExpXO02dIrl6ZMNyVTdE8pKQmaujS5gZY7O7nLXYbSc8usS8RyrjvYP3ep1iGP2CRZMVpjoQtNm4zLyDNAtavQyHnSUqRC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273113; c=relaxed/simple;
	bh=hvGV/6LYvjczCIhyftj8f85ilYz2DdHDD8fn9XutZHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eY3TVxfvqOY7ucXD8b00FCPffCi0LEkASnHPnhgc403VExrpCnGXAjpbUzgBJ4kGmMYxPzKPLXpqOOBXhXJCZmCFVVBXdNqlhjWxfWuoNG3xzySUJku9t0sVkuV5lYHyJn1MymRKBpT/XWFnVIR7PirO6GkxQgoO+StlQirZbMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T60rX+/8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755273111; x=1786809111;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hvGV/6LYvjczCIhyftj8f85ilYz2DdHDD8fn9XutZHc=;
  b=T60rX+/8xjSm06iTWl9BCTnMUIJJqAsPPoIgrbnl58GNn2AwhrIOCE8K
   fWwzK7v+h+JCBbmqF+lTyHu/7pC66u9CnEeGALVXGG+zlAhqWdS2AAFil
   aw1QFqIkSBhscAo81sWlX5nTmluHJ2PV+zV1qWDTx8ZogCaGcVW6JNpq0
   raCIQQ9R/kKdJmFGBlXHi0fFKq3d6kuUSy/1mBuJ+KSg6EtlvXJJrJ6AX
   MBXTv3jK2drMH3q1Q39MmzSID28Mw8h8gHonBHZApFDHV2G0Wqs2FqG1a
   88G1TCVgXGKZ8NaUt3eAx0n0OO/qGqMcNL0AK+bCYKzC6a+WYmiuk46bF
   A==;
X-CSE-ConnectionGUID: FAEvlkHmTo+0M87Ajo6JjA==
X-CSE-MsgGUID: /tzREb9LTeKRJFzdstNJOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="45168436"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45168436"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 08:51:51 -0700
X-CSE-ConnectionGUID: ZW5GmbI/R0ikS9K8Kz7IKQ==
X-CSE-MsgGUID: PHWS0jb7Rs+gq6jUZdPeyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171242309"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 08:51:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 08:51:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 15 Aug 2025 08:51:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.83)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 Aug 2025 08:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H30tJL/g1ahVDyRGZr4Vv6tECUHtiL8JDo7nMgIxs/rc1vRExSZkFhCIUD1CGaLIhnpa8bPfB7p9QeTf/6Eo928fJQAiCqXThIdx5PLSrstkAwuYIP7o7UWA2OmqmDyxgGA4qbED9ZqnFexDdSfiv5N3y7JnI16Q9/E/BV8CcOEbCwX22ZXnUVTop8VMonODDGutEeG9cyjPdF34oKRvRksiHnUgnat4QlKsftlSjqovBBOzLTtZj+u7n/yOIZAdy/+3cpyADT0AdgvKE+LTE48vM+QlSKY2u5j1oLa5r6i6Zbp4kBhOF057csl9GwBrmbBRZIUJSy68fsgb+8TfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvGV/6LYvjczCIhyftj8f85ilYz2DdHDD8fn9XutZHc=;
 b=jL8ui9+nlUADJJ35xoqNfmgMBU+7SjAXfbHxFS8CRyKKdoG0CUpq4G/vJrbiiAXQSgfWzni/vDciiNqb52aSBqjDfISw8CCmb8nPG0kiGDQHYy+pVi3+uXIBcPJUp2ANZYCkthDgWZvBu6q7QJylWTL7MMxz4tYARg2uUfTvG7Cr5+fhQU5HbuqMzlbDvLtaupPBp0mnU1pPoYYH0/aC3BBdWBdVWG2XCMQtZRRzJNdBbuPxdN6+aUj67XfD1MRx0ix4+S40/kUMJZWfPm0WjJLBZ7m+5TL5GaWc8DOnvmEkIEVK5XrWLExjnjYi41tm4BLMUenlhS3hXsYwtwUyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA3PR11MB8966.namprd11.prod.outlook.com (2603:10b6:208:572::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 15:51:46 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%4]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 15:51:46 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Charles Han <hanchunchao@inspur.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>, "lenb@kernel.org"
	<lenb@kernel.org>, "Weiny, Ira" <ira.weiny@intel.com>,
	"zaidal@os.amperecomputing.com" <zaidal@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"colin.i.king@gmail.com" <colin.i.king@gmail.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ACPI: APEI: EINJ: fix potential NULL dereference in
 __einj_error_inject
Thread-Topic: [PATCH] ACPI: APEI: EINJ: fix potential NULL dereference in
 __einj_error_inject
Thread-Index: AQHcDY5DwY6VJsI/w064nAMBTKl4ALRj3Zng
Date: Fri, 15 Aug 2025 15:51:46 +0000
Message-ID: <SJ1PR11MB60832250A17E982F8EA3BA14FC34A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250815024207.3038-1-hanchunchao@inspur.com>
In-Reply-To: <20250815024207.3038-1-hanchunchao@inspur.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|IA3PR11MB8966:EE_
x-ms-office365-filtering-correlation-id: d9ebd578-d476-46cf-e59c-08dddc13a3da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?QmtMXMslKgSrlyjl1k9BMukSjhEXjI4H80OGoazJBFSqquR4lWefz6e8dRsX?=
 =?us-ascii?Q?DOqE+T8JtH6DMG9xVNNzYLVOHa8LtGS+xjUaZSfu6kcNI7IWQHlIiOcJR9uZ?=
 =?us-ascii?Q?c+/p8icU9CeKKashMIVexGzSFKo3oc1HfbBUauNCIfObaQ2jjqfIAMw+DRqx?=
 =?us-ascii?Q?uobgQMpXrtBk7hbIZdENnbLqYeRo6ttTGSLxk0JyqLyavV7XmrfhSDJodpiL?=
 =?us-ascii?Q?Uyjjz2/gnTcQF7JBUTzg7dLDj60Y6E9U3lwngLQPaUvJSso1vzV/tZHdLSBL?=
 =?us-ascii?Q?aIeGIKgFFj2gg1sN8be0jmD0+k2i2ixn7uNsPebuKf9sENnIY/ToCwgA8EhT?=
 =?us-ascii?Q?aTmxjTCHw1TXOQie7yx8HGd3Rx4fcyMKO+E8cxwB/DUTF68yPblV34mfoqpV?=
 =?us-ascii?Q?tg4wuI1qvbAkqHnJfZE8HFw+9xSUZTkOxC8LUk4t7FoGKP/HrEq06rNHGJL9?=
 =?us-ascii?Q?g2rzEtVzLDOi0B4Oc5z+h8n0Umlxo+tXMCoqtA6l0jYk6cYuMSaxKcoNXIBR?=
 =?us-ascii?Q?0tWgQLpWDHMK1NLrRiXn1S0QbMQTLf7+1ZyuJ7M8YSdJ7Q6HFRm9tir2TVAZ?=
 =?us-ascii?Q?nvOCBuAhFofi0U80uauiLEnF2gdbRcqNoBdD1RMv73LLLP0yY0xgzMEyzBcc?=
 =?us-ascii?Q?jQK42M9EGiHVnpCT2mPeCn2CvRCeId+awqSpfqee6i+1ESRhyS2KITAt9a65?=
 =?us-ascii?Q?l9KhAKJBLTHPcy5JquQY4vtNhvr7AnnVbuTMtW9u3Yr3iERUw3ZP69GOCwj9?=
 =?us-ascii?Q?00tJE0q/pBpejxutvDUU7EuOWtzpIY9stc9jhduDExHm0qQisDwqKXy7FVAY?=
 =?us-ascii?Q?wlScpdd3gPPVACZWhg2VEGdGW78b22E/TsNpbbkALjZsVnwefd0ZDjTWczGK?=
 =?us-ascii?Q?hauCf3+0yhdj4WoVW3FNj09PvbA8eXrhBasrmgndahbjGml8en8hRYzrYauI?=
 =?us-ascii?Q?0Phs6/dqdfbH80yhHYp29vqs8wb+eIk9gMC+fCkmxW+3t3lqlarTSR7FsuKo?=
 =?us-ascii?Q?I8ya6BHjQYDMnndjmczhDgF3Tk2/naRD9ypc08NIiykqvyD/8b89L4coPAJ4?=
 =?us-ascii?Q?xn0sBU1eVdUrY9QQ79/817sMJoaRnmcv2mXjMee0IHlvCfWyRwxVk6Rxnobn?=
 =?us-ascii?Q?UwO5xpeg1lGO/s+2i8wXVlon1behtoNSSpwWTxnVF2yYwR7/BK+rPKf/Lw8F?=
 =?us-ascii?Q?0YWEz1PZ7mCo3eF79TXPV33QIImHwzFoOlRwsDsQeyMcqUaPGXGkYQcdq+iJ?=
 =?us-ascii?Q?6sgKRATrJbwR5BgLB6VQkMkT7sBU7WrPQhmZd7scN8unui6PUoAeEJkacX0r?=
 =?us-ascii?Q?SuojWr7M3gKCAOC1AIst2LPpQATHr1x+KfvcZaloXUDImxXpgatKFqfR33ri?=
 =?us-ascii?Q?6hy1qwE0ykvpWD3N+7Mx1s+7GYJf/VTgjBAcozRs0G56m+Ko8JCTQas1+kRg?=
 =?us-ascii?Q?YYtTta3v12LRoiT7WvWuahnaX8ELH2QrC/m/vG9HnrOlD1+OEAsj6BcAJj11?=
 =?us-ascii?Q?9xSyBDLq3eYwi/w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vzRveBf2WvImL8kEzG3Aj7LuBQw2fTCPHELYDt/v64mHeBdWQFTETXF1wb/4?=
 =?us-ascii?Q?1z3xyi981lAiIyXl3UxT2Za1ENNRkrPlqR4Va7TonWuPG9UYuhDXmDqUmZFo?=
 =?us-ascii?Q?aedg4DCXCS1MK2ittlBhlHAQ5TGmgkBurVZ9DLk4qGPleDOHZs9RE+AOKVhr?=
 =?us-ascii?Q?gzu1khZRGJ7Gsh0moXlkLlGmDs0i/w7T31/H5ekTmet8SwbuEhD8CXav9FOo?=
 =?us-ascii?Q?UVOfLgpr9gtn59rwVNEBQDk8q553oQhgqZ9FWnOUnJNVwubf61AloRkoFNiC?=
 =?us-ascii?Q?mDbZetvv1O2HJSb1pxqRhb4yB0YaGEbhk/Acgcrp2zA4TRPEcEH48TRolq60?=
 =?us-ascii?Q?EuSO668vjcaGpmMTOoCBlcFD+b68vaHQF5yNXbveetO1zCNipNuBlqLMtDzH?=
 =?us-ascii?Q?LdjSoSzWfPYkdt+BTPcLm4bnjGxqyF3ZI3lU63JlORGM3Rjz7kQK1OQRBy1L?=
 =?us-ascii?Q?PGk6aXaNgJXZ8hwyyJ2xrmyCa/qDIimnhxYB4UKoXzr1H19nR4mYUkowvkql?=
 =?us-ascii?Q?0kRRCzCVzO77hTkXK4RfTJor3DWQ1dwj4LmSi9E+AEZqmX+nmb3Lrx6rnGwV?=
 =?us-ascii?Q?q33mWbLxVzdRDVNeQ5WFQtKMTMvthVPs6xZJCt4vHERXwsTQ5EZXcVr7S3Ux?=
 =?us-ascii?Q?GSHXHgZIsbn4Dap45JdzXRwLIQrP1JH3bCWQ0V18Oi/dh6OpsBPvWNwt5kkT?=
 =?us-ascii?Q?LRjzA/L5s0GP/SsakzyKecj+8WVGpWOUu7NqYbst6E/HKnqoTgl5Wb5xZpMv?=
 =?us-ascii?Q?00ollaHdX8BykN+6G+eGUyRRMPiiWpjo/o7hGREaUv3QrWSgRvAhoguWHYyu?=
 =?us-ascii?Q?bjYO/ZXVrs4en7rKAbAO0qp3LWaIS8ySyaYYcBwXc6ubxCRx1zw5enbEWUVG?=
 =?us-ascii?Q?+KNAvvVMpFRLwOWI+xtHzrXFCCXCjIQOeqo+/xr36Z4W87SfYIFd0jwueK34?=
 =?us-ascii?Q?agzsjIkhLBGqWUgjTIHw23i9F710tXxxaqbPtBqSvS8N2RqobPM0XyKTyt70?=
 =?us-ascii?Q?L6Wp3olSbvaQaLphONw8iU1tkOysw8e4FKZyeQ+EfWSTO3OKf9pet5o+fHc8?=
 =?us-ascii?Q?Yu1DJD9tidl8v/LJjmIxPcMd39s0JMnMb0rVji3Nx54MOeYdsyu6yBkpoBc6?=
 =?us-ascii?Q?7h9nEPBgyc6f13c3KllQbB3JEaEGBNCWong5X9H0aD/Jj4DO86BgpZtd/8Jx?=
 =?us-ascii?Q?v3wAbOL5nb0m7zBWHcisQ4IQHXi9u5y7pCt70kVnZ8qLiotucaH+IaGUD9aC?=
 =?us-ascii?Q?2S7yJjCikKCrXRef3ecuz7XtUjLKjgIbpW1MmOkyfUKAWdjMZDip8fIhOhLU?=
 =?us-ascii?Q?F7XKOYPalo4yvqceBd6nUFu1hYDMuHdxNdI2xfpRZeRAB+93ck1iZhtpvgOd?=
 =?us-ascii?Q?qafV7S0W+qXgJzNfRsu1xGWUIvQjQGbqs4y2ImhH3lqtgrNJ0akpv7F634tz?=
 =?us-ascii?Q?PHvU6/sTKBAOe+FelcUnQZClg2/5SW8+K31FKQtvxAV15pwsZACfaqnaKYh9?=
 =?us-ascii?Q?73wycnGEz1v2ygi9S8Pi/xxlPGUJcvKixEl5dL7Nii3IEL/HFaQERCgkgwLy?=
 =?us-ascii?Q?Goc3X+thxSBXiowuYrexJpRmpp69p9vzwabLnixx?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ebd578-d476-46cf-e59c-08dddc13a3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2025 15:51:46.7365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i1z/48MODJXzEwZdVRDGPsoBM7dz/jnShTIiV5MVDpW6BqnXxHyl3MyeDoYIPfaegIrz4kUcQH1E3Qz0WRAe7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8966
X-OriginatorOrg: intel.com

> The __einj_error_inject() function allocates memory via kmalloc()
> without checking for allocation failure, which could lead to a
> NULL pointer dereference.
>
> Return -ENOMEM in case allocation fails.
>
> Fixes: b47610296d17 ("ACPI: APEI: EINJ: Enable EINJv2 error injections")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony

