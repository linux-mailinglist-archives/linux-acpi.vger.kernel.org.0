Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC1557A3F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jun 2022 14:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiFWMYn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Jun 2022 08:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiFWMYm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jun 2022 08:24:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42431DC3
        for <linux-acpi@vger.kernel.org>; Thu, 23 Jun 2022 05:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYlf4uOcV165I+YHNQkAtAJOZvOhLSNVznVk7EupJTjLNwCEqHu3CZJMcejUyqOhWaW9cNLnrkyGMgIwcnqM5KapySVOrWuYmoB6b5lZle19ssjo3O8JGdFeiSLwIbwEOOV8oSKabyjJBi5505LKxgstZ1G8DPym3Oj6bnyOQbVa71JAMGKVsQ7DS/L8jSlMH0iUQU9a54zHSeC8OsXZJbTmCzDae9fPjYxK7kVVFcn7H+dHcmzDtEamVPSCp71RV9dLNHB0W2+3tYOOb/kFad4ny6BVa3QIqe+6bB95CiKEp7/qkdh3Cyn0C4Irh6r9QauyEUWK53qrln/3kDY2lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fcBGki8lNswL340H/YkziLvHOflATd4rKaGE87XkKg=;
 b=YWFkAC4r/3I9Wyrm5OmnoQXGUaLnInF+31KTBMg0rW3ya84hxCLOgI+cUzIQk486f7jTlsi34idvH9+8EmrrsIF80VspkAjTS3RuLckYJ5bIoYFUEMDgkFK6pgD5QnrCLXyKrYca65tKXmqRgOgm/cF+5DFVHjQINTSjuMmWwZ0UAtYPg0Bas7mSpPw0SjWbaUoxSWpKcYkQOSKykoXlkDwQTLXlQgqfuuDnfUt6phmShkoLhVUXFiIJlLFWhYxQBIaWKn4G8YflkvP8dAN8XhiJ/PqOIRDxRO9Xj0BLr60R0Abfnrt3T31C2+sWJgzfyMQGsV2MIyDqMBYX2H0ZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fcBGki8lNswL340H/YkziLvHOflATd4rKaGE87XkKg=;
 b=PJn8WnS3t458/T1RWESOWqwas2EXr+Xny7M5x308RLdYhs3H5LdyA5zCoyVSGtm9gh06VF49AvqyxDik9lIzbBBJJ6mqlR4vwoBulNXWR0QFWWcxcD7DDKZskvRSY31NBXSg2qT38AQ4wUxiFJg8MDcoSCVM/elJAvKkb9GmqM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN7PR12MB2804.namprd12.prod.outlook.com (2603:10b6:408:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 23 Jun
 2022 12:24:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5353.016; Thu, 23 Jun 2022
 12:24:38 +0000
Message-ID: <eabb9172-3227-3c12-5553-3de202a2f63a@amd.com>
Date:   Thu, 23 Jun 2022 07:24:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: "Revert "ACPI: Pass the same capabilities to the _OSC regardless
 of the query flag"" is causing regressions
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>
References: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6d7e3740-6107-dab6-64de-b4a978ae329d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0003.namprd11.prod.outlook.com
 (2603:10b6:806:d3::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d810f5b-d487-4b9e-6fab-08da551356f9
X-MS-TrafficTypeDiagnostic: BN7PR12MB2804:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB28041789DCB3338C19021915E2B59@BN7PR12MB2804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4cvUSQWkz/XREporu7/UdGAmt33bYOe3C+CeapEyRS7q6g9Tu9FjUC/hhaN9Xm+YOjNhLC3SB3Ohls6rQ/MGnP4/jT04nuoSorN8ly+fdUudECLQkZ7mw6GAEDGZavLAO8bNHFPAFbIE6Hl+iGL4Ul3ReCtZ9jup5pCk3enIG5pzdMbaeTG2PTndi9obj568LdWXhTCC+84RMqkk2Lzt6FlIk25oX+V5qRW7ESYCoC81E4sqTfM8f7BjZQ77CLX9wq4ixdrueq3ILsN/exQBgtZRmwwWgd0GYHiXKYeiEghaXbDb7EYfz8BvPHpJwgbCqcvReIjQf5/CPY+xzfF/1yFYL9kbj4OMi60PpyyaVmnGKfFwBlzl+hR4e12xALbXGSyEpMPM3jMs1QleTq9UCqROGyRwS9sg/3hmLNybmaTn4ctLTUSnAN71FajeIvW+dkWHsvd5i1E4EsZZMgWsPCHfBkCieDDek83ZxCWtc5jG+M4ev7DRtaNJSyRrpq2BFgzqwDVujSAX6xdtSYwXVAAyeNBy8if35K35ySMKmv7kgv0fgsdmSaczKdTHEMXpph4G49AApC2t/wfEswBKEoeE6OxKzPM26NAirHBQIQWG7y9WbNsujNBjTxNZ7ZJO3ypKs6THgq/o0KLc2ERGFK5DcRceQjQZDVWWOJ7PBlNm0ycFEvn4y6r+/9f2lxcCwQs5UkRQYdj9eC9G+8/v5AV8HAg+qYg3Gji20Ioyi7DNSxnBMVYEBZOEW9ewXWgE8o0RhPkqXwSblJwqdyDvMHgyRBs7Xa+qpKxU/4IVmhFX/Ya19oHzPIymU8qnSfgp9OA9xHVE+py+6B9Ndfe9qoU6sRCXtupIfdO8lE/7H5s0Q6y/EplfdmAbiWJJueV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(6512007)(83380400001)(66476007)(41300700001)(6666004)(478600001)(186003)(8936002)(6486002)(5660300002)(45080400002)(6506007)(53546011)(31696002)(966005)(54906003)(44832011)(86362001)(316002)(2906002)(31686004)(2616005)(38100700002)(110136005)(36756003)(66946007)(66556008)(4326008)(8676002)(26953001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZ2NVBKQjc5MTltNDdDTEsxU0o5MGhQRWFzWmozMlpKQjRYVmhqK2xIM1Q1?=
 =?utf-8?B?bVo1dVRQdVZCclAyY3dEZ3B4WDlhdGs4K2Rvc2N2OVFEdTJiMC93Tko1cnNl?=
 =?utf-8?B?dGovd1F3Rzd0RlR1azNBUG9tdWRzUGZnMmtQK2RZKzJCdXNYaFpEcW1DOHov?=
 =?utf-8?B?VEtmRThVTG1saTQ0bW8xV0xzZzg4RHhKck8vN2pUUk5TNUZ0U3FxKzkxQ25q?=
 =?utf-8?B?YjJzMDlLZE1OUmpZVTgrcEtjUnJQaFExaVRpZDNqanROWFRIWGFZSEIyanFM?=
 =?utf-8?B?eUMrY2lnSWpxaXBpKzBwT0gwRjV1VmRaWi9iNUlrMVhqYWxVYVozcXllaHo0?=
 =?utf-8?B?UEdZOWptbWRoVVpuUWpwNXdnU0IvZCtiMnJwZmxkSnpMSkxzT0NXVGxpOGIy?=
 =?utf-8?B?Q1hUclp5Y0FHZnZPQzVUZjJUbmw1cTlOTW0rZWVQc3ZENDNtb2s1NkoycUVX?=
 =?utf-8?B?MVFaS0tFY2Nic05DQW9zQldUV3Y1bElGbXd1TGJjZlpUcHdTNFJBN0J6RUd1?=
 =?utf-8?B?SWxVWmM2UTBpZjRHYXFLRjhydnBTN3dPOWNaSG9tYXliVWVlTGFVTDlUYjlV?=
 =?utf-8?B?dmNGQ1plMjJValcrcFVhK3lYNHlYZmNkL0lzL0ZJa2xYc3locFk5cGlJTnNY?=
 =?utf-8?B?ckhkK0g1L0haRVZQaE5hdHVwWTdsbDZ2WVRieFZROXhOL1NmcWtZZWV0RXBV?=
 =?utf-8?B?NG1VWTg3ODhZa1BMNmlqSVNNems3VnVjcnVlS0lRVHNNbUYremltU0g3Ymps?=
 =?utf-8?B?eERrdktmWVB2TEJVbzVrcjVBcXRWejRQUXBOYkM5cHdwS0Nuek9sNDV5VGhR?=
 =?utf-8?B?dHpQTkI2UWNjcytYeml0K1lYa09tc0tDS09LWklIMllQWUlyb2daeEFGWnEz?=
 =?utf-8?B?MDlXL2lOQkVQQWttOW5SSGpRVHF5QlB3blFac2g0Nis3eHhUR2FXemw2R3Vw?=
 =?utf-8?B?eVUzNFJuclo5NExvRks5cm4zMmtuNTlXNzd3VGlHWW0vczFzVzdob2xCMi9P?=
 =?utf-8?B?SGlHdEFmYWE1UktIRTJKZkRVRTNSK0JGYlZrQnJqVHZwM0FNRTRQQm8yL0pr?=
 =?utf-8?B?UUU0MVFoYkhqYlZYcWJ6R25VREtzOTNJRHQ0SEV4MkU5Qy9LdTZ2a25RWXdz?=
 =?utf-8?B?MEtuMnFhMUg4c0orbnlMZHE3MTR2QWo4TkM4clhGajlnQUdBL1NBYnYreUFi?=
 =?utf-8?B?MVlIRzZrSGloR2lFTnV2ZWtCd1ZSbEpXYmU5dFNFbHFVVzlIUlRQZ3k3akps?=
 =?utf-8?B?a2d3d0VzRTVFU01adlprenBGbTNiSTl3MDZVeWo5L3BWRmNUR0c3azlTM1Z5?=
 =?utf-8?B?ZjM4U2dwdUNEbmE1bWI0YVpHblhJM3N3dGJMSDM1Tmt1cmRyRFhuSkliVUh1?=
 =?utf-8?B?eStERGZUWlRJRlUxTjhoQTl3bnBWYWpybndLTWRQdW1WQmtONlZPbGcwTGlU?=
 =?utf-8?B?eDBia1FJSnoxeXRyMkk2TWQzNUZUK1ZjWnZiUlVIdlF6YXZqSEx0Z1dLWW5x?=
 =?utf-8?B?L1NnUjM3MENsb29oODdWK05pWlNDTENYTmY3bTd1Q1duWXFxaG5hRlpieHpx?=
 =?utf-8?B?Mzh0anFDd294WmNjQUhnTFZZZElqK0pYOVRzaUxMVFlHeExmeUFpVDFtdkll?=
 =?utf-8?B?Z1FxcFM5SDFGRCtQOWRwanR0QXZnNnZOeEtjMzlubVYzdVIxbG8zUW1SeDYw?=
 =?utf-8?B?L09jaFR6eS83eHJTdFdwUElWMDF2VjhPS3JTajdvV01wZDgwYUdxS2REbjgv?=
 =?utf-8?B?SnRkbmRZQzlmQTBOWDdDeTFjVUpadHVDNEhJRGlxU05FdU9udGdIZUZQWCtm?=
 =?utf-8?B?WVBLR0hQY3Z6S3dqNDB4MmtwUllYT3I5ZFJFUVViVUlYK1Q2YTByelhmWGhw?=
 =?utf-8?B?WlM1WXk0MHppa3pzQ3BLVmxHeGRBb2c3ZTdHYklFSTdxWEVzU1kzRStGVnE4?=
 =?utf-8?B?Z21tRjBBWEtyT01PTGV1MUh4RXdPaGVvTHZ0ZlZXWS9JMFlaTVRaY3puZU52?=
 =?utf-8?B?UFhpZFQ0TnYzLzRiZ1FFRDNZazlja20vQVd4ZUpFUy95b3BJaE1KMmdDRDQy?=
 =?utf-8?B?cUVjRnRIaWwvbDNaYlBLc01PWW9XQW84V1lpYWhyYnFXMXFpLzdYeG5pbUtq?=
 =?utf-8?B?UWZVVjBPRjZWR2NyTk9WcWdHbmVBMWF6MEVhalVqMDkwRGh4dnF5WFo4OGpY?=
 =?utf-8?Q?LM6TkzcyE6it7aLaE0f8nEIFUL/K0jMlgzEyzdSiulZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d810f5b-d487-4b9e-6fab-08da551356f9
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 12:24:37.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDlRo2CKdrhzDM5rvUrzauayGLAluOj3Lcv8CNmAJtpAQ/h+2a33iYbzPY0+3el6qW1uC7BH3ApBO3qdJ5+ZQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/23/22 05:06, Hans de Goede wrote:
> Hi Rafael, Mario,
> 
> Commit 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the
> _OSC regardless of the query flag"") is causing the issues fixed
> by the reverted commit to show up again, see:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D213023&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cf3e0e967549b44bfc78e08da550012c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915756056744972%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Y0NhQJHeimPYw675CW2hxF9BHc102X8Kl9iQRC5tmyk%3D&amp;reserved=0
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D1963717&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cf3e0e967549b44bfc78e08da550012c9%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637915756056744972%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Y02ntSQcVqhiqbVGsxys0BSeiv7BmxIRZIoxzdMHxKI%3D&amp;reserved=0
> 
> both of which have comments from the reporters that
> the error message is back again; and presumably also
> that /sys/devices/system/cpu/cpu0/acpi_cppc is missing
> again.
> 
> Can you please take a look and see if we can come up with
> something which fixes both the re-surfaced issue, as well
> as the issue which the revert tries to address ?
> 


Is it possible that c42fa24b44751c62c86e98430ef915c0609a2ab8 didn't 
backport to the stable trees it popped back up again?
