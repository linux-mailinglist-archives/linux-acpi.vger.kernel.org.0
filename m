Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4341539764A
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Jun 2021 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhFAPQy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Jun 2021 11:16:54 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:57761
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234275AbhFAPQy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 1 Jun 2021 11:16:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJeq09ghplioH8aKQpwxflvO7eDJaOKs7kKL5VBlJovLXWrVopd73/l0Uh/oGYotqGMzueB3bol4CY9rHane1AnHHYr+DbAyVTrHFx2t4srV7zB1rZDOZ0WvVo9m9g4MQlQecBVfnP0bQ/73pM15Hw2oTWw0ym4iC/esAOvP3Z6ezCxljDzBlYk6AHmrxPu/fNCMXL2Mcggnb2OxDnC6O5G4yIU4mR4jb5nj6fEELCmy5AEUOPT7QPyL8tVkKT9KG2sX9t4LrtR3LEc5f34GTI8N91V28j5x3NL053c5Z5D3Ipiwhpb5Ok/ss6R3Dn+Ngii+tbBxJoGoe79i95ceLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exq3dKmdUIZjHrASwPQKbEBhnsM4AdmZgZJWC+Byt9I=;
 b=aUkBDLBPuurm355hwxEEPgdwK8ILUd3JbGiJYWmdV69N0rr09q8tMm92QSQCGBhrID0maIJN1cD3FUqkdaa+b6JzjCWs8pB+9+WzM42QP6XiX00sXHUHmcHOfbYbSSN87PCtsIqKETKUZ3zxl6/xDMRLgaoCfFyL9WFP0mrT9GsRE/n3QOyZddnEqxyxMcwroHsKNdJBH7bPAu4wnCKWFbLnkCWZj2LNxfspwbCHAVZP8Qs8hkY2Fuh8f59RaMr/NwUtMHKgJVhHjRWIpOMpBqMPbdqpb+TACGNx0SZ8PEl+lPYNcrEtJCg+O1iL6h/SH7r/xRuiujrpYHDFwWybyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Exq3dKmdUIZjHrASwPQKbEBhnsM4AdmZgZJWC+Byt9I=;
 b=H0bXB2Pc9CS2st5OGwPlMIhFOAbYe7s3IgwwOoaCDinr0wy1jSE69stwjX8srWUb1HJExXvT6UtOjpnOgKoyvc8h9wRIbm1QgGcydPWQisrbQZd6wIBFexWz6M78SGMpYv8HS7zgsTKpwFZ24x+CsAEMtTluOOIfDdAUevf3MPg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 15:15:11 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 15:15:11 +0000
Subject: Re: [PATCH v3 1/2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
To:     Christoph Hellwig <hch@lst.de>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        "prike.liang@amd.com" <prike.liang@amd.com>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "N, Shyjumon" <shyjumon.n@intel.com>
References: <20210528160234.9402-1-mario.limonciello@amd.com>
 <20210531064655.GA1417@lst.de>
 <PH0PR11MB4853EBD21B8D89AC8138308F9E3E9@PH0PR11MB4853.namprd11.prod.outlook.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <474a58bf-dcc9-48a8-c5ce-fb79f2b76a79@amd.com>
Date:   Tue, 1 Jun 2021 10:15:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <PH0PR11MB4853EBD21B8D89AC8138308F9E3E9@PH0PR11MB4853.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2600:1700:70:f700:38c3:685:3e2c:1368]
X-ClientProxiedBy: SA9PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:20::11) To BYAPR12MB2693.namprd12.prod.outlook.com
 (2603:10b6:a03:6a::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:70:f700:38c3:685:3e2c:1368] (2600:1700:70:f700:38c3:685:3e2c:1368) by SA9PR03CA0006.namprd03.prod.outlook.com (2603:10b6:806:20::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 15:15:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84f7e5ca-122c-4969-32e0-08d925100cab
X-MS-TrafficTypeDiagnostic: BY5PR12MB4066:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB40667F8F63A0B418122DB93BE23E9@BY5PR12MB4066.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzVLu/2Jli1g8wXnvpclC6sP+G16XGjLzZZqGcMhxLDKk8v4LyHZG+ilx5Egb8rTrzeQ/b7ZAQsNqhwNU7RSyixwXS2BARC0a9cHqDwKPl+qqwfrtjU9lhQvGcOWMHL6YmGtc5F5IqxcDChtdAkgrCs/HrKocqvzY4C2hG+aCt9mwe8U/RBC+zge49pWL2PlYTOK/A37f2CeW8xVqcyWpO+gvNzlL7O2t8ymPynmz6utypcPmwlhhAbxFUvAutuTu5h1B9bzKs5y4bz6q1wMv4fueMqgtwCLcO7g/xnU5o1+9XATjChoXULfEbxH7GZwN+6ygQLWf20ZYHnYOWl2Sx4I0NsMzW0+MroE6J1t2PyPQ4YB6YjrpHO/U6xXASt3V0fh6rV7oPqulmXkCJkz6yz9zybjrfHwf8TM6CchdY+27/SWDgoxKuEA/ASV22G0YSR0H2s0Fnc2Rk3uU//C1NfBrAo7RoSHArPbVXI5YH9JWdrE4WgQ464dXM17ByeJ99BKWT/Rhjn+cXZcCc4bc8xs5GO6hENr70hDa4/i5od7BNJ4X+Il7uiD2JJNvxA7Nb+oxERd7bEb44+1oBLVm8hf/KCojwahDZchedYUT/CWmfsSk0iZ/Eq2uDTFYdFeICWQeTV8Y3nSzRfxEC0f48lJ1re2PrnMciR+l5s87WayMtugmfh067U3j9PfR6IicDWh6M1oOLsvcRDGPirlLT4ZuLtOWdWe9bsTGwRvqQpNKRsHWzHHxiGMIniOrFNcLbk5ZDKk4hTxGDbHLDw2LNFlo+vH69Aeh/V6WJAXBd5KXaZwQgjkS6aERv10ja42
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(2906002)(5660300002)(110136005)(8936002)(36756003)(66556008)(16526019)(186003)(66946007)(4326008)(86362001)(66476007)(31686004)(8676002)(54906003)(38100700002)(316002)(31696002)(52116002)(2616005)(966005)(478600001)(7416002)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aUp4YUhQN3dpYW9iZ3V1LzBCVzYrOUdEVDd0ZGo2ckJSaUVNV1FhN0dqeUxs?=
 =?utf-8?B?OWFOcDNEZFFBUzNoc0xycE51OE5LdmpZeGFRZGx2Nnl5WmRnRzkycVdqNE0r?=
 =?utf-8?B?UFRJSVAvOThKQlE3bWw1MVBQa0hTZkNMZHhvTWtPeHNORXRaR3lWM0ZiTFhq?=
 =?utf-8?B?VnR4Yk5iTzNIcGk3a1hCSDNrUkRtaHNkTzlDTUt0T3k3R1ZweE9ITnNHT0kw?=
 =?utf-8?B?dHhML1lrdVlUYm1kMmNTMEl1cDNROVJQSkVaYUNMR1BONHRlL1dxTklKL2Iv?=
 =?utf-8?B?ckNzSmcvNGFHckw1Q0szaTZ3MkxvVnhVRFNNQ3NMWFRtR284UWdhcGZab0xa?=
 =?utf-8?B?RFowRDJya0FISG5sbzhadi8vTDBYemM0dWN1Ryt2cHRyU21CZjhReHNZeWRh?=
 =?utf-8?B?ZmJhdXRwN3p0T2Nkc2paeU9LeVZhRmR5eGpyc2UrZldPSDNLVGo1cHJkcUJj?=
 =?utf-8?B?R3Vxb3ZCUDFCRDQ1cnFaNDRNcXgwMGdvR2tMNE5MQVNQYU5oL1JJdzBibTFt?=
 =?utf-8?B?NFl1UHcwMUdNdEJmQWg2b3VFaElNTXpKM2I2Z3lsSkkvWjVyWnM5Y2xtOGI5?=
 =?utf-8?B?RzBNRWwrcXM0cWxIdm5jc1VuQjYzRVk0ckNyQ0xGb2t2UWN0TkRIcVFXTGZO?=
 =?utf-8?B?dVlhc0tINVZPQnhSWkt3WHNyVkdYTXpSa08zS0hHanNCWGZXZytPTmtzSVRv?=
 =?utf-8?B?T0RCNnF5L2h6ai9rcDNQOEZvZ2tvQ2pOWnBMVXovNTdoQWFRSGtMNENFcm5i?=
 =?utf-8?B?bFM1QXVhdDcwRFk3cm1kNUxybDRndGVCL1A4L2VXWVVBenpNbHFBTUFoam94?=
 =?utf-8?B?dHpyYlVUaWVmeGtQMjNqbWh5OFdLTXo1S1Rqd0ZINkl5N2ZhWE16dEVFR3No?=
 =?utf-8?B?MllyT3g4ZFlFZy96NWRjUzVaMWl4K1RGcFFROGkyeVF6M0FSbzlWWTBjbmhS?=
 =?utf-8?B?dGdhRytNMmNiUSt3bDhzN3dIdndGQ1o1MG1NSFhaWG5WRjg5VjFsMkExV1FM?=
 =?utf-8?B?WWs4Y1h1V3R1YVI1WWt3MzhkMEpZajNDYlhUeVZjaDhtQldWMnNZR3VZQkdV?=
 =?utf-8?B?M1JsaUFkd2hDQm5YU011NnlscE5PbmNjYzF1VlNDWWZBVlBWdjRpZGhaOUY1?=
 =?utf-8?B?S1o1VzM0Z2lUd291L01VY3JaWW9FdWdQdDYzelBzUjE2cGgrMDVxWnI1Tlpq?=
 =?utf-8?B?bVhheFRlNnpJeDF6U3NwYWo4ekZyWm81RmlSTHN6V0VKQkJQYWNabTkzSFZl?=
 =?utf-8?B?d0VRbXh2dEx6YlA5TGdGbzBLMlB0R3N0cEpuRUZERFpsQStTUmRqbmRRc3lM?=
 =?utf-8?B?cnIxem9wSzJvT2pETWxVTEhqK2x0cC9YVlhjU2tFMlpYeG9CYkNtMFU4ZnVW?=
 =?utf-8?B?cE04TERyR3dFaExMcTUwa1ZjMjNoRU5sa2V1ZC9pU1h5TzZPMU1LcVUzMHNJ?=
 =?utf-8?B?RHBxTVVmWU5BbVc0eXlVSC9DM3E5ZWhYbm1GalZLWW51RWg0SFVzVXVNdThO?=
 =?utf-8?B?Q1BzeHExb29JVm4yQklIcGN6ck1qTnIxUnJHMXM0blRwSU4rMHR5bExDTEhn?=
 =?utf-8?B?b0IydTZncHd0azNxcmtXaFhNSDJSalVPNXRqdGJrbWx3a040TXFoS014NWta?=
 =?utf-8?B?NWhLT1JPR1ByVEs5ek1FUUV6NytJSnJGcTc2TmQxMTQxekxWMk9Uc1RIZ2pQ?=
 =?utf-8?B?cHJsV1BXaDFoUFdBM0dSTHlSajUyeS9PeUZvcGdGdlk4TnFmYWpKTXFJRHVn?=
 =?utf-8?B?eEdHU1FuN1BwdEcwblR1UFdMYXkyZ2FhTVZBdlliU3VFUDZVQUNyNW5Kcld1?=
 =?utf-8?B?Y0ZNamxqVG1JY1lkRUJObW9vOVpJOFhtK0ovemN5c2swemhseDFBd1JXOUdP?=
 =?utf-8?Q?4Tj7usX27LaQg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f7e5ca-122c-4969-32e0-08d925100cab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 15:15:11.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGkGwNisYEV2xhDpClNVyNcf9u6uIQfonlLHHjCQS2F8sUKpkKdGGXGvTl1m0YRFiEs546NzPZAyHQJWuJQleg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> 
> I think we need to wait for the confirmation from David.  This looks good, but I'd like to see testing.  I also wonder how many of the simple suspend quirks we can drop with this.

David, do you think you can get this soonish or are you similarly 
blocked like Shyjumon by remote work restrictions?  As this is causing 
problems for a variety of already shipped OEM systems I would like to 
see this series land for 5.14.  If you can't get to it in time, I would 
prefer that we switch this patch back to how it was conservatively done 
in v1 for 5.14 (and redo 2/2 on top of that):
https://lore.kernel.org/linux-nvme/20210527113751.GB17266@lst.de/T/#t

and let you get back to the list when you can to optimize it "later".

> 
> Shyjumon and Jon, can you retests the platforms quirked in
> 1fae37accfc5 ("nvme/pci: Add sleep quirk for Samsung and Toshiba drives") with this fix?
> 
> Shyjumon>> Yes, I do agree we need to test this also. However the boards where which I had these issues are not in my remote access now (as the work frequency on this boards are less and also due to Covid situation),
>                          It might  take some time for me to test. I will update as soon as I can.
> 
