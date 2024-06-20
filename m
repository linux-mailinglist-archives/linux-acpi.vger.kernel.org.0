Return-Path: <linux-acpi+bounces-6556-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C665B91116D
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 20:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7610328390D
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C81B9AA4;
	Thu, 20 Jun 2024 18:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dLXCSNKB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F8376E9;
	Thu, 20 Jun 2024 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909477; cv=fail; b=Ulhz4O5Y3qeraxSOUzWh1EU3qCyWPmmKd6tiRja322qdg5vJpbZZER1lOPPoqGqBsVFwhoEqLE73aOzlfDB/qtZ/B/RVRV07aZHD2q7if4ShVl2y0z42AE4vduu3nJjw09C0CX+EFvgiRI1Xvl0BofIs0Zey25/Hl/eNU4PZs9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909477; c=relaxed/simple;
	bh=mR77qoTymp4xYM+CxcFtFwZ+geQWrmpsB+G+I3i51+Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fEkIBqYr4+iJY9ijju3HqlZiOErk7WriXhfhz9ovqwwhFi6q5KliMn9Lt1LMfhNfd53jkXQL3hbDQv6m+Hn/V2rTGmX3IWksy2f0wh5uDF13ikVo0IaL2iTUoOTSwoWUCkMNRe+30I30268uDbPI6+BeIjE3X/rCyHjFmZTN5nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dLXCSNKB; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718909476; x=1750445476;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mR77qoTymp4xYM+CxcFtFwZ+geQWrmpsB+G+I3i51+Q=;
  b=dLXCSNKBA/1HW3Cbg1IZLFMTbrjDuWeIs0g++Y4fkHO/TuTB0xMEU+e1
   UVEVQVyl8+Nf+hoTrQLAjLKREAdIYmUhAfqceRJ1UN//VreejZNLxvGYr
   QcbrXDQWAttV3f4akubVsgMIs/WBpVWwB0gy3YHF/32WQTRkpNzHRa5aO
   Afhbi/sAxnoeJQ6huMOtAOJaB4i2ZwmF3/dEfh5g/GmwQ0Rxj8XvOHW4t
   sKx99vncyRfOQUR62T6fFwDqmkbsWcq4/gztyXLhRBUMOjUzBU/EUNZjn
   Burt7S1dCiXBhIlosqHKNZHzASgaH2+eT6oZsWPRRCWZuZgK9O9Oiaboj
   w==;
X-CSE-ConnectionGUID: hW7ajQCBQ1ueZQswiEI3dQ==
X-CSE-MsgGUID: cQJTpQUHQSqwnZJJSuT1Lg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="38432926"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="38432926"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 11:51:16 -0700
X-CSE-ConnectionGUID: 4ydZCh80SNWg8zHSQClDQw==
X-CSE-MsgGUID: n88JNN5IQ8+tGustI5Topg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="65587675"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Jun 2024 11:51:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:51:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:51:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Jun 2024 11:51:14 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 11:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrGQYTU0mExMR2ohL4zYJwK/q3tCFi/0aRwl0vSTqcQmT5IfNSfG8OiBhBYyDJQA/vCZv77xTzTX1HvWm7kuQZwE+CB8hp4xOU0+cnTiL4Lz0lNeNIHZo+Wex8WE/aL0nH2CEg3M7IbKzdvBjhoogXZhGDObVs8bRBI8lOqbjtOVNNGqMUIUOgIRGJdA7L9KUnVMjVDw01UXFoqmRSP74UP7SaS62C2KeaSegzFUNocG9fJpbAdOJ9f7kjqcF64FQNMFo0VSPFli1n++XTnxfjLutdpfNQg6ENIok2Tx5PYsGen2EMG78yBR2/Q1X1TQjSPc49TFD9cE4oEsPUAm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be6hzmidMl1Ilu29ANjzLQzF9yb2zNUisqb/hTiayWw=;
 b=AxjJ+7QasVbuAcqGaqltJdmT2Vz8wt8tg6WxJYF7oM6yAZhVWKFDJOXXakwOTRFgqrLRP9Jrawzy+AexliGqCGnDVHSe17cEslvapZJCVlat2bn3spsY93rU+B3QMnLj6gJZ5MdEjLjhIIQB1uuFittUj6QcMHWBeI5xxTVq4evUqoRLsoIIVGdqkJFKOBJPMPH4D5VYjDpGzdr6mA8vnhIyZyfmO/v3mUNOZ0xYMCZqcLFskMOXusnrGS+WTVWfxPa8Aqsqie+pGlT/WzJ5ZU2HasvA+WW343S1xE4EpcojZ8bj8wdfyBZfkr+NMu7H30Eo5xmU7K+J4guzUKb2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 18:51:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Thu, 20 Jun 2024
 18:51:12 +0000
Date: Thu, 20 Jun 2024 11:51:09 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <66747a1d7d4b0_1daf294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240605101012.000041e4@Huawei.com>
 <6670c5b267a79_3101294e2@dwillia2-xfh.jf.intel.com.notmuch>
 <20240620183701.00000029@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240620183701.00000029@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0264.namprd04.prod.outlook.com
 (2603:10b6:303:88::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: c3b9095d-d41a-4fab-0004-08dc9159f47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lrIUMmdsD9+IvK4++Qb+f7YiYqkbmiJIPfaNhF14nRd0xwBmluBAIeEJ7aiS?=
 =?us-ascii?Q?/5liPX7MmSwNNbFP0ml/CLd8XK9JHJKUCKfp1q6oeK3NfhZUh9BjWl/Zm1NL?=
 =?us-ascii?Q?w40gID7CGy83FDmSPTGSM03Q8OI3Pc/BMtOnQ6fuzm5WOnaQPSI0XwGh0Ywn?=
 =?us-ascii?Q?m2WuoZm7Bq3oVIj0WBAohUXAS9IVdcHJ3270xmIOX9ssy0p1eXrXY3e1ers/?=
 =?us-ascii?Q?Kr4PG0eRNJEMm9awJxBD+LwjtvCsRHzTq6U2NeqUMsYT4kfgbWMkhZ/Ty41B?=
 =?us-ascii?Q?Dx5ZiONlxp27kjgzO/RLe+QGjzqE7RD4afc8tO3UOsBWXjCqoFIUKL1eATV/?=
 =?us-ascii?Q?4cB2UpKvFcAcsBqMZYGW6mNKUMzUobAcK4FlpI5eQaEmbxpf6kfdOt1gIOe9?=
 =?us-ascii?Q?foRQ0mOSDHkLIVi/menUMwy3TFt874ZKRlYL6qBA1+vbwqK5g9UhMKcfqCSV?=
 =?us-ascii?Q?vpvpVnJXxLsz/od5Ze+PmW+9z2MN6AxXtoQDImIXEPeMn1BjfqCAO4fRKMoY?=
 =?us-ascii?Q?cUa+P2O4R8+pe5AgCBYi0R8MhA+gS6ulgQiXoygn58KYhQp0fcQ7Gnv0VFpy?=
 =?us-ascii?Q?Rv/CM/6fpSrdCl7il/kaSM+qu+jviOBcqvcxGg9UnDGy1tIKgHmnTMpII0me?=
 =?us-ascii?Q?fQcU7DXzTO05W2UJyVw2hqr9eTJ/7XqcWilys7LCWMNyWJnRVP+CggaYWTFR?=
 =?us-ascii?Q?JNNR8M3Vj3HscWjGioeN4W9quqcBxL3+hU+jq2WcJr/vsIUi3NIGW6zIulaH?=
 =?us-ascii?Q?4JNy8AQAOVDkih84hXB2GwkA390KAizgjweC9Kz9fmxd1pTVX/4p3Fjs213Z?=
 =?us-ascii?Q?468nE+UB5C1WwkOZ6CK3G1LRxngDpkOtPY//QxkoMGKiX7A7DkKvJiOSCMyD?=
 =?us-ascii?Q?4IqzGSmsED9GQZHGmci63chcjBE55/oPRnvBH2jYR1knbW1PlKugn8PQsEwq?=
 =?us-ascii?Q?LzHWzf8XzdTpSMWMsx3HUVlqXhHnoku8YdTcB3+Vk+s5upQoImSD5jR+Fa7e?=
 =?us-ascii?Q?M75lvZeRaTh9hrJ472n98Kr7FTNZGsy0UgxlFxpYMwTsW+a8MS7NzG8d04bm?=
 =?us-ascii?Q?iKe+2uVJczDz9oYqdMaQbbvZVR4h6KVNbTIxuGaKJBPwdWxmTWjuoyNfj7km?=
 =?us-ascii?Q?Eio0gGfoEQCkVe4Xz6/QRJ+0DBhAW2iyY44K8rpnVhuWkjBIADr8OkLYOljv?=
 =?us-ascii?Q?ArK6OenzoZuYdDNClVXJzSYA8iAJ0Bw0dvQXFAlqzL/ptWFxA3vo4XuO61Si?=
 =?us-ascii?Q?tR9KV6kQpGJ/UYa3PrTLrH/6Qjfk/jKKV+5mACfgR+bAJayduokL2JOCaTpp?=
 =?us-ascii?Q?TtiMucZaoyei+qVbaecTK+wm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hgTBekhkuSejvNrpxHql87FZNuUIi9K9eeUlB5IxUGJpVlP11MleiqnoEhK?=
 =?us-ascii?Q?Vkou4bMYOWnMeqy1rauoeobokWtZ8FUwe5UG3DcvrVuJAAEJDcYOK4eYv2L3?=
 =?us-ascii?Q?qyGUEA8HVBSCc1bBVJGNKa2QYFs3YaJnqbAayF8hcsWaXRgj9l3lUJRXLhAZ?=
 =?us-ascii?Q?D0jDnFLcsFZRtEnhcANXw45qIDFaGAaJu2DbzZLratJ+ojfTMr7vnAP5eKdR?=
 =?us-ascii?Q?QSSE+sEBuK9ShsxHa2R+nkRDwyeszQuNeGSVWfqt6pwDvfkGD5M3qpaQFhPi?=
 =?us-ascii?Q?3bq51zCshvdcl/MzDa7e3ObLLxiY7/dLOhz7ztq43pCP3C/LLO3NNXADZED6?=
 =?us-ascii?Q?wpSROe4cmUKkAbWVKZBo+5yyBRrticFXEgcYN5JTM9N3OCVah2mJzIxqxtn3?=
 =?us-ascii?Q?9aRqlI0HvE2glqf/h3Bk4tOZWPKlfgAry+BPrxBj+8zB/QCukO5mXNGVKBp/?=
 =?us-ascii?Q?iJdaAukI++TEi/ZDKntyr9VCOMBIxyCShNeltOydslb8K0LUNn7Vr04Dw5nK?=
 =?us-ascii?Q?w1GbDiI/XPsmiQb/ifcoJmN3CxYNiA+yn/hTETwdB6UJqSkVk/ggRUo8FLV9?=
 =?us-ascii?Q?yIj4sv3fwzkovvqlasjLVZ5pOdx9HHfkSWzprqjO4PAT0Bx+cEBKTWAr/kXv?=
 =?us-ascii?Q?Hfz4vP+irRzZSOEgUW2IHrTKxmYwyY/TmqXlgZYfb3uvtL4CwblV+JXMzJSQ?=
 =?us-ascii?Q?6A7uzAFjdx/EdkXeSj6r8BtwoOkRHjTZJYi9aU+O1unt+sw5+F651lps+lad?=
 =?us-ascii?Q?QYXGHLQO6dMo9EepxZ8GHwa+ebHATDdcv/SqycEqHFXR0S6F8tiamCvsG362?=
 =?us-ascii?Q?EugwvKnFohSRqsMyJmsQ7Nrb22ZiQmtouE/KZMXKN1OE7/dKaaJnchlPatJE?=
 =?us-ascii?Q?g+f5ORTIJZ50zMduHlH7nixs9FcpVy3+defE4hIv+leeFpVlnWCv6+jNlMcO?=
 =?us-ascii?Q?KPIfnORAwujwbK+85diC8AF7YKV5G7uNrPNAvHGVucnHPGpH/Mw67uwbiW8R?=
 =?us-ascii?Q?zA3OPsk3fKvUijEK5sWmse4lIkMjJBsY1bhebW7unOQzSN9K0/YAcVMQb/ec?=
 =?us-ascii?Q?+eQXAkL8e3iZ1w/1gk3eVLO8zC/nhFPBQbTIht2zIqG4rM6pA1brRjSiI6dd?=
 =?us-ascii?Q?JSaa9s9Ng/iBDAdB6JpcyWtFZIsqzATQ2zeOHtWJFj/9FTJ74jRDNb7MA3xS?=
 =?us-ascii?Q?D1qfReyDdjRcGoqQTSYL5wsXXy3rVOeTEaTYb1ApcH9QxwRJBrCb36MGae0D?=
 =?us-ascii?Q?z10p5NPCMHoHgtD3vFXn1PrYNwYNz/1JQkhMAYX7w+TBrzQa4jR3uN0L/Gdh?=
 =?us-ascii?Q?FWFQHh14iqkyFR7kjhEkzdFZ8aKxijw6wbDkALzap2zwMEXovGEiZpKb6u2W?=
 =?us-ascii?Q?zBcJydLuWw3iJ9NgWpUIVktB0KlScHkZcWY4dWHOeshBtG6JJPtw4tq9ukmF?=
 =?us-ascii?Q?/ngXmDhTlooL1E3gjmu3WZE7A9jlKqTBM1gvY9THOANf0FYqQNVuIZ7vBn0R?=
 =?us-ascii?Q?ooa+ngwT3c0FmQ0GnM5FWlFNgIXpzwWbY0rmpHj3vPA1HePyPnbBhWYGa2DZ?=
 =?us-ascii?Q?g1MNDg+Oy4i2JNxNrEeVRLhgVh02oUy/K39/SNuaIJwam7X/lJcN4RVVFyuw?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b9095d-d41a-4fab-0004-08dc9159f47f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 18:51:12.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaf/mG2fDUrMMLrOu8Ansx0aTB0yX8IltGTHGa3KjdiS9ii+8PROf8CF/m3B5Zl55TueJtcoj4ik+4zEGg3TRY+yL26EdGdTzQzjE6h/IAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
[..]
> > > I'd drop the 'may assume'  Also after this change it's not reserved.
> > > 0 explicitly means transparent cache addressing.  
> > 
> > I am just going to switch the parenthetical to "(Unknown Address Mode)"
> > because "transparent" does not give any actionable information about
> > alias layout in the SRAT address space. So system-software can make no
> > assumptions about layout without consulting implementation specific
> > documentation.
> 
> I'd like an option to indicate that we know reported errors will not
> involve problems with aliases. Something like...
> 
> 0 - Unknown (all bets are off, read the manual).
> 1 - No aliases.
> 2 - your one.
> 
> A simple write-through or write-back cache would not result in aliases
> for errors reported by the backing memory.

This seems a separate proposal, and needs more discussion because there
*are* aliases. While there is no HPA aliasing, there is a FRU
(field-replaceable-unit) aliasing. So if system-software wants to
determine what indicators to fire (i.e. replace cache-mem, replace
backing-mem, or both) to the tech servicing the node it needs some ACPI
help.

I would be ok to do:

 0 - Unknown (all bets are off, read the manual).
 1 - Reserved
 2 - Extended linear

...just to try to keep the list ordered by complexity for now.

However, I am also worried about the case where folks want to do "noisy
neighbor mitigation", which is something that has been attempted with
PMEM caches. This involves knowing the layout of cache conflicts which
need not be linear and involves reading the manual. So, I am not sure
defining a "no aliases" indicator now improves the Extended Linear
proposal, or is an improvement upon "read the manual".

> Assuming we don't get an address corruption (in which case everything
> dead anyway as uncontainable error), then poison can come from:
> 1) poison happens in the memory itself (fine, the DPA in CXL is enough)
> 2) poison happens in cache and is written back to memory. (fine
>    the DPA in CXL is enough).
> 3) poison happens in cache and is read by host. Synchronous handling and
>    the HPA is available and enough.
> 
> Not much we can do with 0, but 1 at least lets us know we have the
> single right answer.

That is, assuming that this is caching CXL. With CXL, the DPA
information is available to disambiguate the source of the poison, but
for memory-side-caches that are not backed by CXL, what does
system-software do with that "1" case?

