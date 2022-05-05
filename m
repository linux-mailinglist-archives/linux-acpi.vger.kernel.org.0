Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645151BA3A
	for <lists+linux-acpi@lfdr.de>; Thu,  5 May 2022 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiEEI0n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 May 2022 04:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347715AbiEEI03 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 May 2022 04:26:29 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBBAB7E
        for <linux-acpi@vger.kernel.org>; Thu,  5 May 2022 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1651738968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RUqByuUsDroqsed63iht08fnodE19ymV/mVhPXeY+RE=;
        b=hvRZCjsBlE45G+Oo9hlOT0ALQvIapWYkEEF+HyZYIf730IBH53jSFtWArJ7d4eUsEMr3tP
        qmkMbT3zsCOpr2+h4sTD8LgWUbqL+yXNvEA994DkVeXq/R70Cy0ejPKqUSFLIHVnKkokqU
        YoWEyrAduVHEskLAbIPEEB8rUbM8fQo=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-GlCUTJM-N5iE0v3ZaxajVA-1; Thu, 05 May 2022 10:22:45 +0200
X-MC-Unique: GlCUTJM-N5iE0v3ZaxajVA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYJuPQ6cGBK8Z4mWETeAZoLoCDes/us/A69G5b95PIqDZ7UZ4P16nEQBSTf830leyBH6GC7bUiCpLHPYA/yBpFl0KWEKvXMAjZ9m2ZdYozhYJQaG3mTHBybI74wsJD9zYNzEEisyO7T51Bn/3hjaULeA4aHaCHm4ozga39PuBKkr87HVMKdKP8EAtjs8ll858NaDDk+IMzJNSpg/SMutNJXrZ3O9Q+OH4/0Lrf1AW9rg44WqqvqEPnt7oCvmwfiWNil8S8e7yZFbxk/7INx5VSV/dExPIkK/bZyHijcsMQGJrMMA97DsZWUGtXfM1nGhA8wI0EwN9MnQ8xBU0E89dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyuz05MqgI0duh32uN1DZmLWDMYWDGL39ERP14igzLk=;
 b=MrD+8CDvn+tYlMoAnU7/eaPkSkxcT4uLGX+8DXu+jjYP3M1RUivw2nKCNv0+GevypMTBpxdJSs3nF7qg4hHdcYoGAyC5omTxB1mnAeTQXdeJxx3aZiItI9QtbyJ4sOKz5Pr5x1hDCPNK48c1BcAEVqVGmoZ6sC3lxd2x8nobRJx1wQzdNlGyENiYFXuRyHK214K4zEE/YqqNVVag8AcGng7MXZRQd4zrJ+luMp8DjUX7/HAFZvCPPe3fYoNJv2B2w6pst5zWG509BMlTtD3PyaQ0sMp5WBL+XvEX/+99/+5560CE1FYX+TLQJuYvtrGD/OJuEsflXQ7Y5PckfL544g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16) by VE1PR04MB6592.eurprd04.prod.outlook.com
 (2603:10a6:803:124::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Thu, 5 May
 2022 08:22:43 +0000
Received: from VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b]) by VI1PR0401MB2526.eurprd04.prod.outlook.com
 ([fe80::8c82:19c5:ce96:491b%4]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 08:22:43 +0000
Message-ID: <40b8ad06-6ef2-113c-fffb-2fa001603b3f@suse.com>
Date:   Thu, 5 May 2022 10:22:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/7] PM: Solution for S0ix failure caused by PCH
 overheating
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, rjw@rjwysocki.net,
        kvalo@kernel.org, alexandre.belloni@bootlin.com
CC:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-wireless@vger.kernel.org,
        daniel.lezcano@linaro.org, merez@codeaurora.org, mat.jonczyk@o2.pl,
        sumeet.r.pawnikar@intel.com, len.brown@intel.com
References: <20220505015814.3727692-1-rui.zhang@intel.com>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20220505015814.3727692-1-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6P191CA0069.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::46) To VI1PR0401MB2526.eurprd04.prod.outlook.com
 (2603:10a6:800:58::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27a6ec71-f522-497e-7ded-08da2e706cdc
X-MS-TrafficTypeDiagnostic: VE1PR04MB6592:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB6592583C2F34CB8884C378F5C7C29@VE1PR04MB6592.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gF3PcqyKrbCZtaXeJJA1TRtYoQBUyDueNf6SQXFxcsXVr5lIkFYNBrUi10oYuE13aloMBuL+A/8KNazT64GuVJ4eGu++t15auQT5P/vT+ieXdm/FOc3yKeM/5zeqLm9HcWYrBshIog5UAXuwFAZ+DhrIoZCdUdmQ5ZXocxCnos9zFASwZaA+fG3Db5d/WIuRX6vT9wNfWeFykK4iWoy0KNOdezLGQCeF4X2sH7SHm9kG1u1K2fLCWzd2LzrbnbmPkd++IONnYFe+Swono+uMT1IlC4SU88Z4dsGz5DOvG6TQxBLVwTl4eqLDyl9BpfEMzd1D4iJVjzCoH5+lytJ44NffpP8UywfwSvJo3slpV0NPGTxFOvgfzDIjxE4cT/bQG2bdPlWx5/1dg0/IiIZFPU4Dsp9QaH/YZ11Ewz7GAc396mMmM1cHd2ZD6aQehmO66fvy80VQszENTBkkWtAK136IQGK+YDdwCV9glAz4xKDi6FFSw972I3M+7CbcaOMq3ywF0sAlWxqJVldvoyBvQy5C4+VAMNs+PkBRWBbiQajbUIgzxzOi4ATx1llnKELybJUfteyh9JYrLkH/n8a4zHbRKNjXVTBQL54AaOQHc2/bx5Zn9Mvza+fT3jTQ8JzphDCkSwo83G3TYQ5lW0JPzzzeHIwZiokfL4qwflx2Iyd2ZAZ5i1abcjdpaWsQGA9YAnfi9xRgCl7MqYA89nk6TnWsWcRASTb6bLv4KvbeXeNq2EAdpBChqiLAKgVtrRbTO5VxnxHKCrJid9tnmR4gZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2526.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(316002)(8936002)(2616005)(38100700002)(6486002)(8676002)(5660300002)(7416002)(31686004)(6506007)(6512007)(53546011)(31696002)(36756003)(4326008)(83380400001)(186003)(2906002)(86362001)(4744005)(66476007)(66946007)(66556008)(226253002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lR3xHP/FD4NJ9Tb1UoziAUtMMg+SoV9+Wlr8g9azKjfjASAQMcR7bVgHEUul?=
 =?us-ascii?Q?f85XGXEvE/bfSjbhDB63D3X8a707o5MsZwzpWiRSWGujEY8rzLVRvxADdsj+?=
 =?us-ascii?Q?R0T0mpXW0+ew4W3aJHoLcAke3T1eJsHYD9qEAX3j0WhmepuyGOmXRiY/8/Kb?=
 =?us-ascii?Q?7+uzwvZr27CtgWh9nKK9e5f8aLKIrPctKA/O3GE1zT7bm5Lk2n4sets0uoWw?=
 =?us-ascii?Q?SXfOdXK5MCX2b7WE3S/mQ69HHbgFna7GvfQHMdfPg8lNr9YcNQVO/Ti3xInv?=
 =?us-ascii?Q?2kea4RFRGzbUKlrozVt2879bIeQNqyvZT2jUy04godCrwvPv8jL/DAVnzerd?=
 =?us-ascii?Q?gcUwAmJKDwRQUXuCkIwoNVkHMNH3tPONG1qUipwoyYDT7j1Ux897P4D5BwUr?=
 =?us-ascii?Q?DduZUeCog12jn414oioE+kspLzzVahkYlGhDVUNHHYJgmVoI6Ha1Lgy2Z0ka?=
 =?us-ascii?Q?782dVsUmjVxj8Z4KPGRE20Jr3qgffkltd1956ACjyR2093WQY5OukbyBTOsY?=
 =?us-ascii?Q?LQ/YwdXBeG7IxSTH4+bA/b9g9fVDAfqmsozjGB++FzVM68j49wjDPmjHv/BK?=
 =?us-ascii?Q?6EZUkCDRmc0WDqn54awCuOOhdwVcBArC4qDjHlAnWSdPgI8Wb6R1srZRjEso?=
 =?us-ascii?Q?giJCk7hZF+5ytCzD25gHDfQBBX5mVeZ0ZTZT+HLJMo18VYaxOg9hOppKzo59?=
 =?us-ascii?Q?kFTM1ySYjgNcUjphpkQwaO4PchjWLj3EO8362GobQ0VRQ0/B4R3Jv8L8Cph9?=
 =?us-ascii?Q?Msx+wmQV6rG5Eys5icxbrq+AGPbDVL4BkN+rD6YH+TCfo0A0Ubul3PAF5Ild?=
 =?us-ascii?Q?RNk11ngvTDk7vLrwfpSMtYqv5eQyv0SfGWcLfXTI2SV4G6XoXBIlTeAnMjl6?=
 =?us-ascii?Q?PEtiQWftvOYMI0My5u2x8cP6vJzzoTjTtKENtOkjjLtnZDJOPEpC602/1HUA?=
 =?us-ascii?Q?7tK23NhSy8FW5ifuyHqfEYOHbHgxiZGQzG1DTCfFGw43tF4gb2iLpM4wgtY2?=
 =?us-ascii?Q?M/WEJk+eXdbnyBNg7Jm4Ctz7d5PyCP0GN3pqzq+FQ6RGHeKP6eLPhkCEAjqU?=
 =?us-ascii?Q?6zg2wLgPuGj88NjNapHMKjrNhXmhqTsq1keaQwKv6WHU0lpUzoK/tKA6SGO4?=
 =?us-ascii?Q?fppAx462ETdva4ozs/bAt3W/vLRbNZqaGKr+IMSQtpQ2CRO0dJ6pqOefSli5?=
 =?us-ascii?Q?6eM9fNscWh6+7QAD5859FNE3jpliARjHD+UIi/3TOii3UFMyrcErBJNXzpmN?=
 =?us-ascii?Q?MFBZFEDxPeia/dtK69oEAmiJMhYTnpDX1z1aCym4gNk9qu2PF4JucMbOYFWA?=
 =?us-ascii?Q?/Z6dePjj2DzXJKc3r9L/w0Q+tTg5N8Sn8WoeqlVw2oRgWvB7CMZ47Mv3naUD?=
 =?us-ascii?Q?m2McAAmHbiA02Zt87FU9TgzS3nwPuXpYkNoU4yk0+ZwCIkaMq3VT/SGbctQ8?=
 =?us-ascii?Q?EReDOAY+N1Fl/c020eytPWpdviaQz6qpO5upICXbNoKzpegz1OJZww6MxiB0?=
 =?us-ascii?Q?IsO8YExUn4zBJOP3WM0eFp0LdOzfyzdViwKcpjYT0Qvdmxtqphv7mFW+Tf2F?=
 =?us-ascii?Q?RUf0A/l5MvQdyLcB/f20cHnS1ULtYWsWYUAAOxyPkYRSSSHGQhSsujUV5JQI?=
 =?us-ascii?Q?fun6pZI8A91ygunGlqMbi8+CH1tmaVPW7Uw1R/4Es5w4UhqSunBKTFnfE1Ye?=
 =?us-ascii?Q?8T5ozUxVtpXwUcg4q/J8OISSu2FpjOWn+dtoV8LO04uuMD6kcVxU89XtJ+ZS?=
 =?us-ascii?Q?/ZyU4r4fq6wnfO4EatbBZx8kBD2bHqAzbDmYwckuwv+op/WUSUvGC28tELpt?=
X-MS-Exchange-AntiSpam-MessageData-1: QhqSC8o2YsE61Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a6ec71-f522-497e-7ded-08da2e706cdc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2526.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 08:22:43.1450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSCoT+A5QxWQMpqqVH5LggQeEMnhlMlAMiumfivwIGrmn+KGkutHK5FOynMA2EkO6uB/8hRyqyD/MU4yPIZEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6592
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 05.05.22 03:58, Zhang Rui wrote:
> On some Intel client platforms like SKL/KBL/CNL/CML, there is a
> PCH thermal sensor that monitors the PCH temperature and blocks the syste=
m
> from entering S0ix in case it overheats.
>
> Commit ef63b043ac86 ("thermal: intel: pch: fix S0ix failure due to PCH
> temperature above threshold") introduces a delay loop to cool the
> temperature down for this purpose.
>
> However, in practice, we found that the time it takes to cool the PCH dow=
n
> below threshold highly depends on the initial PCH temperature when the
> delay starts, as well as the ambient temperature.

>
> This patch series has been tested on the same Dell XPS 9360 laptop and
> S0ix is 100% achieved across 1000+ s2idle iterations.
>
Hi,

what is the user experience if this ever triggers? At that stage the
system will appear to be suspended to an external observer, won't it?
So in effect you'd have a system that spontaneously wakes up, won't you?

=C2=A0=C2=A0=C2=A0 Regards
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Oliver

