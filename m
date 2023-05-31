Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B93E718988
	for <lists+linux-acpi@lfdr.de>; Wed, 31 May 2023 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEaSrW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 May 2023 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaSrV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 May 2023 14:47:21 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D9101;
        Wed, 31 May 2023 11:47:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh0Qxx2ei/V1sIAJ02cVi+MUJNXWFP1flPyBlk59geZsrj+Sbv3QAp1NY2e6HO9Pd6GjObsfu+XC7jXt3bSEMm9Sa0yzX7D6bWvFQ0IAiCJ4gZqkai3NGkevmvBsdyjtx6YKTr3/k0JUOvJDRr1Wy6qN6aSNBdinY2iDQMz9N2GMY7ZDKJFwr4DyI93D50n9NN0J1XDzAZbv/MQ1vhWmuDWPpmI3rnUsUf2pWtCx0Nqcs7DzdhYkxLyiLAS/VyHHMkgpYvJlfUCtdO46Of+/XaZ0PCvWMKW7+C/I6115CoXuAtLxuYftJvOLBJIJewEcTvQEteSh7AhupLeYw1W+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew3656HX8B2cIOXiOMtBjrBMePO1MVVHcSmTpb845sE=;
 b=jlc01LVw1G7T26MD00wovjRA1CKI+Tc1xjsYqZT0Uehu355ajdRmKgLBKtt5Lmj+LDbeW7D6TqrGoicfrAtTpQX7J9vopmxw9FC0PGIACCQmixeKWOVSwm8yea/VCmeOHnG7LYYWtRJrtoeH5SEFxa8i13s7Qgiwds/LvOy5Iq+O9msCACsISPqgH26Fogd5diNKpGR+3TErULc2t3w2bu0dJDWpDYBBl6kNdItnMhkxGn9dpFC9TrjoouS4XuSsLNBKQ/4kPm1eLIn1sdxknnDGa7x4TAmk3/OqEvIJ5J4o12WOTqwP0shIxROzICRHKnS4Sm+fkTEDB8b4ObuVaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew3656HX8B2cIOXiOMtBjrBMePO1MVVHcSmTpb845sE=;
 b=NhnhWHb+6DLFQioOXv9Kjzj/XqZOowb7cJCSuxmrqMs3ExbkyJAdOQil+Ob7KX88UT/LSPayNZ0bEETobGJHi2sIq6n7qmidMneRNv6xUXlaauDc7iOannY+2L4Ewpmykr+QyJ1ZGUB9NQD/iAd0mzTepoqspeaH1Jf0oDiFvLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by IA1PR12MB6355.namprd12.prod.outlook.com (2603:10b6:208:3e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 18:47:17 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::a3e2:5f70:7a4c:8ac7]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::a3e2:5f70:7a4c:8ac7%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 18:47:16 +0000
Message-ID: <c3f90ff2-463a-7227-3551-50e9a27e3150@amd.com>
Date:   Wed, 31 May 2023 13:47:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ACPI, APEI, EINJ: Remove memory range validation for
 CXL error types
Content-Language: en-US
To:     rafael@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com
Cc:     yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
From:   Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230403151849.43408-1-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::19) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|IA1PR12MB6355:EE_
X-MS-Office365-Filtering-Correlation-Id: f33a99d8-9e90-4d8b-fdab-08db620774b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBaTB5tTin8K2m2V/xN3YtoxFAVcGkObSN71xYdZ2LuKzEsf4C9rBnRNHsTL14GvKKRAreV+eJybcwnfCmLnsjUOBqGswdtH/dxStZ4bbfCli2cKGafQ4gvOujNGay8cR8oVKsiSGjK/TM6LGBKlmECHaIF/dD4u06RxuQJF5yaQ8+iVSAvmuTuyQFJuSb6ahE7RpRzfmGS3ZT6uJi/c567jQyWti2P4fdCEjx1U0h+9nXA7t8KgPXeXHG6v6OgSbZuN6vIRv3FJjs2BshzbpY85FYm5WO5TnFciV+VPAVm4CGlShtwWou6DVedKoCeh6mvZ6iAQwt1bH4E7hYEQC8bcDPkpRKcv5mYAKpkLcK8Vww671VFF92/0otbjOqjTeTBNZg1yZhOS2FIq2D8bfQFzJWaN8F+HHtH45yPUOh+olMINdbydUqHLB2tFc6GIDOv+G+k8tH9TqptpHL6SHpFjmfIu8UPBayzhqEDyf4aLMDOc2NriH+OhCiqFkI9f18PwAKaqLaGtPU4OxllUDzLaDEVrT5gW3Bydibv+M0B3B8No71mVHdT/eHsVuj+31stgl5Zrt9C9Gcc0BB1zgvpHOLuqwrina2krML3epvmit9Zu8j4mvJHiS35w2t7QXjTUagMFRwqR+YHoQsgPjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199021)(6506007)(8676002)(8936002)(6512007)(2616005)(186003)(5660300002)(478600001)(38100700002)(26005)(31686004)(86362001)(41300700001)(6486002)(558084003)(6666004)(4326008)(31696002)(316002)(2906002)(66946007)(36756003)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDEzbXUyZ0N5cjk5NVM1VWlvZWhlTWpsaW9pQUcxcWdjd1RlaktNZVIwUkNw?=
 =?utf-8?B?OEVueXBRMklOREc3VmtEQnBMVGpoZ3NLMzhtTXVYanhudjNpdFZtbVhmMEM1?=
 =?utf-8?B?d05vbmhVWFdITFpUYmt6YUdobWZ3UmVkMytUeHBDMjU0QnZIYzVrUktXUFhG?=
 =?utf-8?B?MnlCOHFzc1kzZGI3OWlUc3ZUOERZMWg0SFcyLzNEVTNpREpIcG5Xcmp2Z0xZ?=
 =?utf-8?B?NGROKzlTQkVPUGFRL2owbjU2SW5lZU13VStvdW4zN2F6YXdxOXRBZklzRHcr?=
 =?utf-8?B?bG9XUVRaNWRNZmMwZS9veUJzOWNlZVBCUmFJWWZodmZZcGZkYy9RLytoVkNJ?=
 =?utf-8?B?ZUZmUUJnaFFvOVpKSENYMTBKTExVdUUrYlpTT2tBcDhhaTlXbGUxb1pEekdJ?=
 =?utf-8?B?OHpLNGY5djVVU0g1dytxMmJDZVIwdHVKMjVNNWZuUmJiNWpRYU1qWmtYaWIr?=
 =?utf-8?B?Zjk3bmVLL0VHTktpenNINkltbnkxaWNaVVNPV2JEZ1Y1TUxjY2tUK2dNamFE?=
 =?utf-8?B?K1kxN1N4K2dWbmxCRkJhYjZ3WkdKS2M4cmNDN3lYbDNRT2lXN1RKSnVBT2Ry?=
 =?utf-8?B?R1ZkRjFnSXpSdEJsRE5wc0FZS1dOUytHVFBxMVlkR1NvSnhtMnBEY2RMa1hZ?=
 =?utf-8?B?T1BUSlFNR2FFbVYzeWpqdXF1V1ZSb2xGU1dJZVRjVWptblMvWExuaTlmOEtY?=
 =?utf-8?B?VWFiaDFCaUJ5VmVxZEEyRENub0NpMlFDOEpuVTc0RjZiMXJxdFZ6Z2wrR3Y3?=
 =?utf-8?B?T2hXMWZPeWlLR0NsWnZkTFdVNlZucGhHUWVtYUNXemdFVlA5M0hGRkJuV0FK?=
 =?utf-8?B?SzJ1OHhwdjdybFVlQXF0Zm9PNzJhMEc0VjVmYmx1bEtlaGRCRUw2dVhOTDhZ?=
 =?utf-8?B?aVNUQUZDaHBJNVd6NjNYdFA4WElvZ0JjODFFT0liVlk4a1RnYTNkTzFtRUZx?=
 =?utf-8?B?RjdraXM1WVhXdzJpQ0o4WVlzR1IxNWEyenQ5V2lkYWJ3VzM3L0VhOXdpQk9m?=
 =?utf-8?B?WWVvV2syNFJzL3h1VyszQllEV2JSRTBaWXNseUFvaDF5YnMzTUlXdWlrQWRJ?=
 =?utf-8?B?cGZhRDNpVERrbks5QVFaUWVDTnRnM213R1NUNDErVFJoa1JtL3kyNjFhbGdG?=
 =?utf-8?B?UnZBZFNFbTZZNmo4a0R1SFVkTVo2dlZqZE1RNmZkUjc3QnR3VnRJYlFTcEdJ?=
 =?utf-8?B?ZjNBT2NqWG9XdHdsTGtUbUhsSExyZmpRL3JSV0JSVjhwS1dhNWprbGs4amRI?=
 =?utf-8?B?UVc4QWF2SmNOdUlHTUxjTXZUVFpnZ2Y1ZlpaR1BoZGVVUFdsVHk1OEtFend3?=
 =?utf-8?B?eC83c2tTRGJFUEV4NFlPSUFwaGJjVjJLS2tjNFc0L3NTa2JlZlR3SkdXUEJo?=
 =?utf-8?B?a3BnSmh3TkQ3anlhb3d1ZHUwRVhqcnpzSDl0bXI1aG5WTm9yT25tcW9mTTFX?=
 =?utf-8?B?VjJSNlhPYzU1bEVTN3hGa3paTXRrbitHM2FJT0tQK2xSeHBGL0lMUEs4ZnY4?=
 =?utf-8?B?T1NMZUxiYi9CbUdJSWw0dmVGSnhNUGpnNHgyMks2NldHUDZ4WmFPZTdMVXUw?=
 =?utf-8?B?c29qMHUxZlQ1dVVSUldIYVJhOHdEalhIOGpidmNESUVmekl6R0YvY2RFaTV4?=
 =?utf-8?B?REg1RkNDT0ZWN2VlWS9aZDhObGcvblljN24ycytDZ2VmMjNvVXVXNDRJeERZ?=
 =?utf-8?B?ZVM2SnJYWS8xZmVtZkpwUzlmcHB2U3gra2hDUnk2ZlRvS2JZSlBqTFRCV2M3?=
 =?utf-8?B?OUJMcnREaTNZdFFVRHhBM0x6aDVkTTdBVjBZbjljTUhDSTlYNWRIT1FjUGF2?=
 =?utf-8?B?WllZYzFnWWw3Mk9xNkMzcGVKUnl0Qkh1ZnpGNWNXWXg4bkc4VUkxYXdxNkdX?=
 =?utf-8?B?TXZnNWJDUjNwSjl4Sjg3dTlhWUx3UGdlMW1odWhqdWhmd3VEQ1V2eFVkRHpv?=
 =?utf-8?B?WUpxdmNsRXYreUp5RFVyYjFNc0RLSnFwZm11bE9SR09IdDZpSE1BZnJXWWFz?=
 =?utf-8?B?VTFBRjVScFJzQVR2YzRlOHFHT013NTUwcXp4UUxTNWo0NWxndG5td3g4L3F6?=
 =?utf-8?B?LzdQMnhSYVFlYm03SkxKRHlkTU10NFEycUpxTzdDV01DRzhxRTFSbDI1Yi9s?=
 =?utf-8?Q?iLqwebCF1C4lIQbMZNlwKKTD6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33a99d8-9e90-4d8b-fdab-08db620774b7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 18:47:16.8589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Vrhxd96kXG6cSScX8gbbNrNJTj8wNZhF951imJXgKJbxH2Ln+9Zy+Cw8eq+UQmUf+mesIYTveXsPwTDzaIs0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6355
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It's been a while since I sent this out, would any of the CXL folks mind taking a look at this?

Thanks,
Ben
