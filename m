Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156272D057
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jun 2023 22:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFLUSE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jun 2023 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLUR7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Jun 2023 16:17:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D839718E;
        Mon, 12 Jun 2023 13:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686601078; x=1718137078;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=39P3b/PxRzC3vKtXd+GbK+0pxIwtAh8ab4d4WSAyAqM=;
  b=aRhf5h+4axBx6XivSR7SC0iK6SAcJJolPLVv1ithaFdzTb7M27ldWP1G
   LTy1cKdDA1c0b1ak/LoOvR5q9uiVXfKOt4TtEVxJLAYsCfTpN6zCThQK8
   Moh/UMtLqxGu6Qs2NTDSumV0FK4jaOPJQf64i3Jwl0XEF8h305bkMEKaW
   m0a2cS6SqviU8eaGvyF6prfx2HJ66dUNCieUweGT2oBukt+A/J1eWg+8g
   GQKrHDWsNk5n3JOXyjiaSYZyxdj9CLzWzvWBoVEBMezqsUcwUztrmJ9Py
   hIJu+iMV+vNSGKYytiyKmfaAjd+jep7a34J17beztwdUSgdRg6LCCC1uV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342840472"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="342840472"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="885576665"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="885576665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2023 13:17:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 13:17:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 13:17:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 13:17:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjl28ueOBZvhcy4IIlFBW43u2oQulDJyzoEhKqXaRCcN6q2CKP6Yc77FyCTOq3m0m9UgIcfnUXAXY47FSg8nBg5ht4yBygke9ISGRCJAMRmWbz1zrWEKkSfy0pxawfPp2X5xLJYvRNvxnCJe/+rC9KlA3F722nDN5plEGh5erPv2bFMKLC6yN0StvrIFZT2YGBwAL3BxMYb7EC3h78YzN2LFacs8PFsi3erouQCLNDSQsJtnpEVupqhjC8YE6cSZCduR0Yu3FW7PoVsxJEBddB6EHg7p3B8CSoRUJcHq1shhvoxKYNGcNi64tY5V778CMuedD6fjynvrmjkapjYuTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XArRUqgg6W4MiTvC5EMARX4Yzmv+TIaGuhLSZOL0Txw=;
 b=NSK41b1/1h9PK07BtTZkCWW1aegzNFN3pvMhFBuglXBn+KSAwG/QvhLbhCSZkwvMz/7s3b/dytiyu/d5tVatE7XmhA2FAZilgYtsBFEq6vdP9OllZh5SCZjtt06N79CEs/bBuC+QqgrTg9OeonQ2OTCZFJnN4oyTeVQ30kwRMWFHUFcRHWhQojCg9kztA2WJ1lvuIQSLA7n3KgIFLSiR9KWVfzXLPwhzIFSBGw1fdB2i2lCyjZeytUOelJcNjJkhjxDdtCzJwuw9Fj5m5p1Jdgh8KUSDGttmAsg+Xw81My4o2hkMqVar2Qcyti9nUp82GEB+pSiAMvbGctdtBEJmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.41; Mon, 12 Jun
 2023 20:17:55 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%6]) with mapi id 15.20.6455.043; Mon, 12 Jun 2023
 20:17:55 +0000
Message-ID: <2251abee-201d-60ca-6d1d-cbe806c7dc0f@intel.com>
Date:   Mon, 12 Jun 2023 13:17:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v3 0/4] acpi: Add CDAT parsing support to ACPI tables code
To:     Hanjun Guo <guohanjun@huawei.com>, <linux-acpi@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <lukas@wunner.de>, <Jonathan.Cameron@huawei.com>
References: <168565502116.1098279.131831312990693128.stgit@djiang5-mobl3>
 <0076edb9-7e65-eeb4-38fa-fb3c4a112a40@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0076edb9-7e65-eeb4-38fa-fb3c4a112a40@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: cf359d81-2ab1-44c6-7b42-08db6b821b37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bs4pA3Sbazc0bkKUv8vNG8rp14Gy8Gd0CSyXo6Tk6R7PB8uWcO8OeaXd3dHVspnGiqqIIPfzk+mP+bTh08OxaOymIo1ICgEPUHRX25ikXhkx8/W2ARYYgs8lHIjTeIR6cRqZmQrZ9AmyX7l7Iv19LziCa/43OZPBSY/ejO+eCkpzKW+17z/7fFIdqxb28KscmcHKqfvMq1nDce1wpvS6auwlj/7P/3QheYuAm7ZIIkNV0uJX9WSg0b2qbj7C/TPUpupDlD7HRixNXrlGQ6/b8k7RDkDV/SP//kODEo1um7+xaMNuejjMvcFZh+jEO4QLs2JRn58ljBKdoec/VdYnglMqV/FlMk4P6LSoprnJT9CJEl4NIIFFmAL5pGcPxazdg82oZl6m0oBj7ZuIU3p0OXSErsAt7j47qCIuABzX9pZLgUqI5ArrQLh7c4vLMbsANeEH4i7i/+66K2UwRZAE4HNqu7oJ4PHJ5zVoAvEnzKYzbWWDJ8iYNhbJFZeXQ470PzkcxQ1JchRnwJZ4XVv0HKnq1hinj2WYUp2kSAazDdbgmexJYLsQc6/Eoo/UZ3RNGdNjFXJO5SWU3Y9cNitjCcJrms4FswbNplBfJxXmKsDcL6k2c28Hc+JMz0CQYHbNee4CMoRADXrEx8/N9+TbWw3tR2REaKpWsqB2ymjW7Ak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199021)(66946007)(66476007)(66556008)(478600001)(54906003)(8676002)(36756003)(8936002)(5660300002)(6666004)(31686004)(4326008)(41300700001)(316002)(966005)(6486002)(38100700002)(6512007)(44832011)(82960400001)(86362001)(6506007)(2616005)(31696002)(53546011)(186003)(26005)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDY5VzJHTzVCMkhvWGZsbGNtYW5XNWNsRGFZWU5nSGZBbVZ2YU0wYWVPQ3lq?=
 =?utf-8?B?UHlKT1J6STQwL0tKNzhtTktOZ3FQOHE4QXZXa1ZHRGZaMU1seGNVZ3N6ejVM?=
 =?utf-8?B?dnRETi9rZ0FNdXhnZHNKSzFSSGhFSVJVMU5aY3BGa0JNN2tGUXUvT2hWbWhW?=
 =?utf-8?B?OWRoYlUyQVNMNnNyakp1Ky8vQ1NrYWliNnVhQ29LU1F2TG5KYzFvK1ZiK3VN?=
 =?utf-8?B?Q25NTFRuZUV3engvbS96aVB5MVdnV21HT0VHcEtrdFB1bXoxMDZNRng5Nlow?=
 =?utf-8?B?bUV3RTNLVENzWWhHYSsxYy83eUJySXhpbnNoa3RDcVlab1dDeGt0MkVCeXkr?=
 =?utf-8?B?YnNPTWxZTTNxUDBSUmtBN3pocUhZMDQzZE5ISU15cUtyU09tNXcvSjVpYW02?=
 =?utf-8?B?NUw2QmNSSzd5VDNVWWxML2ZKbldSVkNxVmUrMHZWS0NMSGpaZWplMi9adGdz?=
 =?utf-8?B?R2tlYUZQa0ZMS1RkcDhYL3ZKd1BjdUFtTTVZdHUzSU9SOE1VR0xjRlAvSktq?=
 =?utf-8?B?cWNrcllWWWxNZHFHVVdjUXV2MnZXNndadjIxOVR6OUdhU0lwcXdGdmZOVWlI?=
 =?utf-8?B?cFh0cmVLU0QrSFJOYlRTYzhVNUxPY1dlS0duZ1hmUXZsbXpXK05rOVVOdkZ2?=
 =?utf-8?B?MEE5RStia1dKNkJOWW5XbUJ1cit4S1ZHZWowMFdpR3hQdVFhV2NmOHJUdDk2?=
 =?utf-8?B?RFRlODU4Ukp4a3lLTHh6a2JMSWVSTSs2N3grb0pEam1jU251WU5iMnBEQVNu?=
 =?utf-8?B?U1N1ZGM3T1lxVVlWcDJqS3o2UWhjSXdsV3VEc2RWTG9uM0lxSmZ4N05QaGZZ?=
 =?utf-8?B?Um5BUGZGdWhDSkRjVzY5S0pYRGZ0WkhzMTBJdkp1em9BaThQZzhJcmtNdEpX?=
 =?utf-8?B?UmdTbzNrN1E4VGpnUlV6YldORTBWZ1JXMlBlSXY2b0NTMGV5ZmtpMUhNK2pE?=
 =?utf-8?B?N2tIYkcrczNWODMwNnAzUUJ1M3NlT2NDY1huRzA1TFVNTlpWcnFHUkUzeUF6?=
 =?utf-8?B?ZG51L2tzL1BPeVc3WW8xcUE4Nlk1ZStHbmROWTZERzRSZVJJYVhBWWhRRENR?=
 =?utf-8?B?WTlFYUFkY2xBK2VQTTF5MVhCdDdoeWRNWVNoenZkWHU5K2hkTXlrM3BCMmlS?=
 =?utf-8?B?aXpDTEhCdzRtc1pYai9mQlNrU0diQTJKb2tXSGtFZEYySWQrL0tOU2p4L0pH?=
 =?utf-8?B?SnNQRFVFZE83b3hNSFM3aDdpSGM3RVZmc0tFMXhaY2NwTzV1MytmRVJtdVJr?=
 =?utf-8?B?c0Y4MTU3bkxEdHNlVWRyWjB4UzIvRDFkOFMzanVGcnBIM0tEN2R2MWJ4UTVH?=
 =?utf-8?B?KzZQNldva2xwVzhuTmVMUW5Vd1UwT21VSzBpcDBVY3dRVFRMNUZjTG1kbGdz?=
 =?utf-8?B?U1pzTDB2a3Nlb1hOUVFNYWFyV2ZmVnF1NWlqOGJlNmF5N1ZQTUNscDZuZW84?=
 =?utf-8?B?dUg3bTRIT0xvS2xoR3dMa3RmaDByUXRNcSt2YmIzZG1ra1pLUmgzTDI4bzVW?=
 =?utf-8?B?M2ZIL0RJWUZUazZWTHZqM3QzRWlUalh2VVlyL2Ezbm9QeFFhdXJ5TjNEZmhC?=
 =?utf-8?B?QXRIVzRxRkZDSFB6bkhjY0ZRL0tJQVJNbmRFZkFjVWluY2gzOXZqTzhROGhZ?=
 =?utf-8?B?Z0plR0hLeWRxQTYycWM1aDkxSGhVa3RpdHp5djh0dWJGVzJVbHN5cnUvRFl6?=
 =?utf-8?B?RGhUTGQ5bFdFcGZ5Z2h0TVFGUW1MV3NGaG42V01QWkZlSzEzRjVmdExQaG9L?=
 =?utf-8?B?SDlPK0QzU1VyNml3b2pDNjRLVHRNYjArOWtieCtGaFM0ZUJkMmRyWDRCOEtY?=
 =?utf-8?B?MWk5TGVYRS9ORFNOWXVjMWdyQWxtOVROcnRicnhkSG1zM2JINS9rWlhOSVpi?=
 =?utf-8?B?aEJwZ3RFVk9nRU5mNCtUZVRYMjZpbEdZbkg0ckdka2x3bWUxK3hnWVdPQ1RV?=
 =?utf-8?B?WVE4WDhRZ0xwZGZzUm83QzFVa3JTQjNuOXFWTEQxNTgxSUFhSWVITWJrOFRL?=
 =?utf-8?B?RC9ZZGUzR3FiR2s1a0JMSHFqT0FpT012K29PdEhHaFA5bmxzMkRrOUhram9r?=
 =?utf-8?B?NUlFR2xFOUtPWXZxYktvNy9VajNteVRKUUNkUXdUbkphNXcrdDMrM0F4L1Br?=
 =?utf-8?Q?YK9T9c7Aq09TpnOgqCCI3B/FS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf359d81-2ab1-44c6-7b42-08db6b821b37
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 20:17:55.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3gThSFBHUdZFgA6ms9KOJzIwGrNV7iIzMKKEFuLXO/kyDWFOYm3C+GqQeiLdVZPrf+87TgxakgCJTnBnfOltQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/5/23 18:36, Hanjun Guo wrote:
> On 2023/6/2 5:31, Dave Jiang wrote:
>> v3:
>> - Move common code to lib/fw_table.c
>> v2:
>> - Split out with CONFIG_ACPI_TABLES_LIB to be independent
>> - Fixed 0-day issues
>> - Change CDAT releveant names to prefix with cdat/CDAT instead of
>>    acpi/ACPI. (Jonathan)
>> - Make table_header a union with cdat table header instead of
>>    'acpi_table_header'. (Jonathan)
>> - Removed ACPI_SIG_CDAT, already defined.
>>
>> Hi Rafael,
>> Please consider ack these patches. Dan can take these through the CXL 
>> tree. After
>> attempting to rename the cxl_ prefixes of functions and non ACPICA 
>> data structures
>> to something more common, it seems that significant amount of ACPI 
>> code would be
>> touched for the rename. For this series I left it alone in order to 
>> have the minimal
>> changes to ACPI code.
>>
>> I've broken out the "cxl: Add support for QTG ID retrieval for CXL 
>> subsystem" [1]
>> series in order to make it more manageable. Here's the first part of 
>> the ACPI
>> changes. These changes are added to allow reuse of ACPI tables code 
>> to parse
>> the CDAT tables. While CDAT is not part of ACPI, the table structures 
>> are similar
>> to ACPI layouts that the code can be reused with some small 
>> modifications.
>>
>> However, in order to be properly utilized by CXL users, the tables 
>> code needs
>> to be refactored out to be independent of ACPI. For example, a PPC BE 
>> host may
>> have CXL and does not have ACPI support. But it will have CDAT to 
>> read from
>> devices and switches. I have created CONFIG_ACPI_TABLES_LIB in order 
>> to allow
>> the common code to be independent. 0-day seems to be happy now for 
>> all the
>> different configs and archs.
>>
>> 1/4: Split out the common code from drivers/acpi/tables.c to 
>> lib/fw_table.c
>> 2/4: Add CDAT support
>> 3,4/4: These two are minor patches that has ACPICA impact. Has been 
>> merged into
>>         the ACPICA git repo [3].
>>
>> The whole series is at [2] for convenience.
>>
>> [1]: 
>> https://lore.kernel.org/linux-cxl/168193556660.1178687.15477509915255912089.stgit@djiang5-mobl3/T/#t
>> [2]: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
>> [3]: https://github.com/acpica/acpica/pull/874
>>
>> ---
>>
>> Dave Jiang (4):
>>        acpi: Move common tables helper functions to common lib
>>        lib/firmware_table: tables: Add CDAT table parsing support
>>        acpi: fix misnamed define for CDAT DSMAS
>>        acpi: Add defines for CDAT SSLBIS
>>
>>
>>   drivers/acpi/Kconfig     |   1 +
>>   drivers/acpi/tables.c    | 178 +----------------------------
>>   include/acpi/actbl1.h    |   5 +-
>>   include/linux/acpi.h     |  22 +---
>>   include/linux/fw_table.h |  52 +++++++++
>>   lib/Kconfig              |   3 +
>>   lib/Makefile             |   2 +
>>   lib/fw_table.c           | 236 +++++++++++++++++++++++++++++++++++++++
>
> Who will maintain this file? since it's the core function of parsing
> ACPI tables, I would like the update of this file in the future will
> Cc ACPI mailing list.

I can add a MAINTAINERS entry. Since the original code is from ACPI, it 
can be maintained by ACPI subsystem.



>
> Thanks
> Hanjun
