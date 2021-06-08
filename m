Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C157239ECA6
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 05:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFHDEm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 23:04:42 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:50010 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230356AbhFHDEm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 23:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623121369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sNw6QuFaX70c5DQ0OYJyyDgpin4AC8vOKsIfGKxrQQ=;
        b=c25u8pVpf0WcTUGAs9043rx71nbr+64ZeBL5DZC441CpJf5Dgk5z9EbjLZzcDQA5jgu1a+
        JIOok4C0ctutINKQtj1Mid1WCb0SbxaNi6eyaV4Wp1qpBOnlpwH8WZ5UXoAkVayJZro9cU
        R2QPGxviifgQDbyKqJaW6if5SL5j34o=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-40-Cclm43q_N3aBOjlzXpYWxQ-1; Tue, 08 Jun 2021 05:02:47 +0200
X-MC-Unique: Cclm43q_N3aBOjlzXpYWxQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSqYNkBccywu8S5dTmb6V/rEI8AtKqngQqVaI6tzv4XenH/I1eBgvZKiRU4E1NWFwV+RWrDEZH4CsD2npU/NgpfHcXTZ/Oo6mQqv4wOS6xQ+4HeL3ZMRK1OWw+S+rE8S5igRYmTEWZva6v26MgkvnwqnS3pDcm45/i+sH6wBH/tot0uns13c0/MeIjzozMZ5KL2bfpHNc+Ok9OegpKWfYg5sdOc8m/8a8KXD9noFPygGK/u4V3lRpzj0TzIyyez1ZwIHbMkQjc4boZhk2PfmcmkwYwfQV5GCxGtj5mTemoK6KsJ8ruBgoTcN2fPe3p3l2+Gb5pqqoqsRAbcU9TF3Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sNw6QuFaX70c5DQ0OYJyyDgpin4AC8vOKsIfGKxrQQ=;
 b=MwQ/AKjE4I+MJHy/Umj7+0/7BZpcAQWXIIx1sQZPwx7939aKvsHcZ25eteGoktXB10S3/ZWUs1a00ERY2WM5pHNkHYv+AsnFcCObSBe9BlsGU9YrD1wygjEIzZnwqTvQ++QMpyuII982ifWGyVeKoJt/lhWG7M9Rsrz7hgIiSJHHxqGv1uCSiSmHVpPfI0zJNFYX2V+7yW6YiDqRgz4az+djsk+PtToqXShTadHC8BdCrE0WUJXeSh7OYndGXeP3y4rs12lXS6Q82gcBBHckvHAQ1ezh5wTGUzaeFGfow6P0EEVG6uiVTX1k+zXTVtly3OSZ10/WuG4zF46Cdyqtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB7006.eurprd04.prod.outlook.com (2603:10a6:803:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 03:02:45 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::e0f8:e927:79f:232a]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::e0f8:e927:79f:232a%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 03:02:45 +0000
Date:   Tue, 8 Jun 2021 11:02:32 +0800
From:   joeyli <jlee@suse.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, iqgrande@gmail.com
Subject: Re: [PATCH v2 3/5] ACPI: Execute platform _OSC also with query bit
 clear
Message-ID: <20210608030232.GH22028@linux-l9pv.suse>
References: <20210129083241.72497-1-mika.westerberg@linux.intel.com>
 <20210129083241.72497-4-mika.westerberg@linux.intel.com>
 <20210203081415.GR2542@lahna.fi.intel.com>
 <20210607123110.GE22028@linux-l9pv.suse>
 <YL5FExiUMfHi+K/X@lahna.fi.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL5FExiUMfHi+K/X@lahna.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Originating-IP: [124.11.22.254]
X-ClientProxiedBy: TY2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:404:56::26) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-l9pv.suse (124.11.22.254) by TY2PR02CA0014.apcprd02.prod.outlook.com (2603:1096:404:56::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21 via Frontend Transport; Tue, 8 Jun 2021 03:02:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 305ad89c-882b-447f-6192-08d92a29e3a9
X-MS-TrafficTypeDiagnostic: VI1PR04MB7006:
X-Microsoft-Antispam-PRVS: <VI1PR04MB7006746130047198F2CDA662A3379@VI1PR04MB7006.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yv+vmpxOdsF72WwYrXPLsscCB2cub/uNk6OKXCwUwO8CpK3SS/1A5HWt5vEwubIkqBzBl/Anc2BiBCnRS9msTCOHFQ3XXM/97dH8O4JgHYF6QiOtMhLZZ/tfrGx++9NYFOx3Bwq33YZG/J4xd7YtA/qFqM40uqdThcB5XlkYyC7z1CMyZtvRHVUPxpPOoY/Rg6etRLmYgXPMkMT+o19RDj3LOEz6Izsnwhnfy7uBBCeMLCu/hZeIOYt/xXG8YqomPTJqmQLPo8ETO2zbzPpLx8aj7BcSir7eYU0Ab3M5Cyf33jsMWzV17ApTMUJOhXBuSKujvxzXF59YDkZjJ4OarvwsLOT4ZKsZ85JQC264ir7rveobiows2BvguhAIwdEx7Mt9n5PyrcGmIqXmSyZABi4Cvjc9RmOyO4mUkQicgxdyn488ow9Mt/4dB5lbmo0YtAnFlz0Q4a1iQ86JxanBq/vjcH8/gYclE6XrzJ0OncN42s8aEjdHWnvqfjdty6VcnBD4C31/rS7SkyN74NLcKp+A+zl6HNRmTsfCK4vZdo+eX+QPovaTXovPdijuEXivFp6Wn6pJNHeX1DalC9uT2ZXElyvYl/ly6ZaorzMYLyNVJSl+D0qWJ0sy+MdDXXA+x33gsIxfMeFGnFAQyzuFqWyjjXx9kyAjjR7Qgu64E/eRIzi5WCJOmGuEo4rAOzP+0IfR29zHciKPb02x5vbNaJK47gZaG8XlfLLcHoHMXTKHB2AYAJxqqxfHSDaUyePxQzprnFKTOn3IhUW7QjqViIoT6vNlS+5gEAwVpvEW7779hSE3Mmo9WuOK+/GcoXqS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(376002)(396003)(39850400004)(8936002)(36756003)(2906002)(7696005)(38100700002)(1076003)(4326008)(8676002)(186003)(966005)(83380400001)(6916009)(9686003)(478600001)(66556008)(316002)(66476007)(6666004)(66946007)(8886007)(86362001)(16526019)(7416002)(956004)(5660300002)(6506007)(54906003)(33656002)(55016002)(26005)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ODbfUoiCOlGGPH9nlZdtb4abvNNmTlQlLxdPIb5Jr19bUqRd/8O0DlRFkkNU?=
 =?us-ascii?Q?bMhyJtEyXcXvMcC5BXZoYUOnAg8Nz3TtboRM1hHpUbEjVUT1HK66IN5QMszk?=
 =?us-ascii?Q?lNGu6H5SdSD++I/zcYYvdU9m6d5Sw7v4AoN5QllLNjPaoKdUpczfdkFkSjng?=
 =?us-ascii?Q?9bzf/j+uhc57VhQRX/kQi/zXP7KyraEJOr4XHegMXVrJZ+ywCrq0d1+hK9O3?=
 =?us-ascii?Q?BPbzx/hZncfceH8obDR8XJ0T/Yj6J0cddTS6zveiZyFCrQPwmsbxrvJMRhaf?=
 =?us-ascii?Q?IbX+SWR74ouogR0necX+N+O2v+b2vjRB/lIXCf533G8MYVRwbF1ioxSGugFs?=
 =?us-ascii?Q?nrmtKnDEL8gP4bwfr3KG0v3mH+iK1KO8wrS3iEFfYV1LrwLPOHOQjcIB1BPp?=
 =?us-ascii?Q?+kznaI8ocSb/tfO75ZntEPPr2lRnJL1u5ks3ZBPHd7Me3jX+VIm9zeRCIHe8?=
 =?us-ascii?Q?dNF3ma+KjV4NNaKFSFEn5u75dl6JQDlSKQ+KTZpmu1ZFI+aT3+V0y07npBrA?=
 =?us-ascii?Q?suhfvxjGj4cU1iQd1Mmp0rZ23dOoh3IMvRCeol5DjZLYalExF3WPWJqq97he?=
 =?us-ascii?Q?fc0VO3VgOFYp3bMw0wI7rgIUK91gcE2RR21sAE7dyEG7RgxFurNO5PwJpC10?=
 =?us-ascii?Q?PTKM8NFMtDrU4vgBRDPsnPxosGcFPnf+IFqHPiRy26rA6wjWgLfRbvCYt7mn?=
 =?us-ascii?Q?Wr/V/3rCho4qHt+gXZb8IH8glb9hik/EF0DMYUlAZAmEr5Xlt8zZwXXDvQ5M?=
 =?us-ascii?Q?6pAJNDeBGdpAxFfA8JkxqtmHD0tlNqOJDzifGXYk5ECCjUcqL74MNXaiXbkL?=
 =?us-ascii?Q?WCtgyhYJjDsuF3WbWwivsBRHqY0/WVpac1W2CewP0XMINfiFZvJv5TU7/Izm?=
 =?us-ascii?Q?ygHHtLErqKmjGLORyOMulebTyRCQfKH/6l1Bl1luzhu4kKsoQZRYHlz2zXwn?=
 =?us-ascii?Q?qKaS/jB5vYRxJGz4uxanw8g4WjZQd7KxXs1O/7KYgl0QMPxn1i9AxdLhS8Kj?=
 =?us-ascii?Q?segovi1mCoPhwjD2bOns5O7LK2p1o2oU9ETZIAPDXC0nwM5KboCoZEBKjCO5?=
 =?us-ascii?Q?TjHRa8dzKuEgPajT8KcdWApolv/z+XXPjsoq9rvtrh1e1+V2mA2su9GH34R/?=
 =?us-ascii?Q?QmgNEPJk9WCiLoRWHSQnmRrRU4jDzXZi7HcQr4JNFbl1K6zRhWhxz7Fa0t9D?=
 =?us-ascii?Q?vxfyuE49JI/VAJL9USA0FM1bU1tDbMscEYkMcG3JK/1SH00z0/tJxuOhkKLo?=
 =?us-ascii?Q?dl77HtaZiy0uC8eiaYJOyptrKYl/NsDaVZv/mf31e+sGkGwNigkOrmXz4XvL?=
 =?us-ascii?Q?bxHNs853K7C9qG6JePel45Xr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ad89c-882b-447f-6192-08d92a29e3a9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 03:02:45.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrZxoYuop+GP4t8jeoKqSMEinCRHMh1i47VxEK9zsDcqpV3wUyHOGmx4fgvEHPia
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7006
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mika,

On Mon, Jun 07, 2021 at 07:10:59PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Jun 07, 2021 at 08:31:10PM +0800, joeyli wrote:
> > Hi Mika,
> > 
> > There have some machines be found on openSUSE Tumbleweed that this patch
> > causes that SSDT tables can not be dynamic loaded. The symptom is that
> > dmesg shows '_CPC not found' because SSDT table did not dynamic load.
> > 
> > [    1.149107] ACPI BIOS Error (bug): Could not resolve symbol [\_PR.PR00._CPC], AE_NOT_FOUND (20210105/psargs-330)
> > 
> > Looks that the firmware didn't response OSC_SB_CPCV2_SUPPORT after
> > kernel changed to new behavior. The openSUSE bug is here:
> > 
> > Bug 1185513 - ACPI BIOS Error after upgrade to 5.12.0-1-default 
> > https://bugzilla.suse.com/show_bug.cgi?id=1185513
> > 
> > Could you please help to give any suggestion?
> 
> There is another one that Red Hat reported here:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=213023
> 
> The Bugzilla entry also has a patch attached [1] from Hans, can you try it
> out and see if that fixes the issue?
> 
> [1] https://bugzilla.kernel.org/attachment.cgi?id=297195
>

Thanks for your information! Hans's patch looks reasonable.

I will backport to openSUSE TW and let bug reporter helps to test it. We will
add comment on kernel.org bugzilla.

Thanks a lot!
Joey Lee 

