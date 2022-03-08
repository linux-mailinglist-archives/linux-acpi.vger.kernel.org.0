Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61464D1F5A
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Mar 2022 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348506AbiCHRpo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Mar 2022 12:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbiCHRpn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 12:45:43 -0500
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD17755752;
        Tue,  8 Mar 2022 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
        s=Selector; t=1646761485; i=@lenovo.com;
        bh=1OneCfmyAMJ+sscG2+JxG1yBk+pc6LvR507y3ATkSa4=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=bmv7H3AB04OYZ2drPKtkt6p2T3Pd8A4O5Yabp2SmqWUP6IUmrCBRAr+/8BrOvBxGY
         rj/cTmy/JkHJlCGj0041amYa4kJ+lSSG64zEEvMPgGh3/217GJzODBbh+LSs17cD+1
         sMlXpsLLEwvXE+lR293Cki/hgP9Id7Vm7QBNM2tVoaIJRrt9ZNu2mS+TRcMksy26rZ
         OvNRhIdU4EjrVdsfqGpWw7i9+U4LdHzbGzvyZ2Idif7ow4V9bgC4LPxAGS6ZbIPbe1
         PWc9lCwIurD0tXf6EkHaM7yFMSv0086xCA9ag+h6fRJcCvZjiajVGJZp/TqFId+N6J
         Kyf6kPWgyGUBA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRWlGSWpSXmKPExsWSoS+lrcszTT3
  JYP8KTYs3x6czWSzf189osXj9MkaL1XteMFvM/TKV2YHVo/XSXzaPTas62Tze77vK5vF5k1wA
  SxRrZl5SfkUCa0bf4+eMBVcNKzb+nMPYwDhFo4uRi4NRYCmzxMXtZ1ggnEWsEvvfN7BDOJ1ME
  pPn3QNzhARmM0lMPXSGCcLZxySxYeoOZhBHQuA4o0T3oXVQmU5GiR+vTrFAOBOYJC72PGaEcB
  4zSjQ8bAGaxgnhfDnoDWLzCthK3H7+nhXEZhFQkZh+5wsjRFxQ4uTMJywgtqhAuMT9Z5/ZQGx
  hgVCJa3t/gNnMAuISt57MZwKxRQSiJH7MfQB2LbPAVkaJ3VPWsEFsnsgssfLZV7ANbALaElu2
  /AJKcHBwCthJnLgZBjFIU6J1+292CFteYvvbOcwQhypL/Oo/D2ZLCChKrPh+jg3CTpBonnKUE
  cKWlLh28wI7hC0rcfTsHBYI21di1dNlrBC2rsSsuQeg4jkSXw7MZoKw5SRO9Z5jmsCoOwvJz7
  OQ/DYLyXmzkJy3gJFlFaNVUlFmekZJbmJmjq6hgYGuoaGJrqWlrrGhXmKVbqJeabFueWpxia6
  RXmJ5sV5qcbFecWVuck6KXl5qySZGYMJKKUqW38HY3/9T7xCjJAeTkihvdJV6khBfUn5KZUZi
  cUZ8UWlOavEhRhkODiUJXu6pQDnBotT01Iq0zBxg8oRJS3DwKInwTuoDSvMWFyTmFmemQ6ROM
  epyXNm2dy+zEEtefl6qlDjvrClARQIgRRmleXAjYIn8EqOslDAvIwMDgxBPQWpRbmYJqvwrRn
  EORiVh3maQS3gy80rgNr0COoIJ6Ag7IzWQI0oSEVJSDUzX9uYkF0w7vtIs7LP4O7bID/ysRyM
  6CotnmuyX33DMXOrQ5P0GGaVW+xbmRbrU7nV6a7EtcdlUFraUS+cXvGRjFXaeENTP+Ch3adBf
  a8kEXpFTl3gPX3lwPC69mz3ra1ySTr3YY47w1KPR+6QWlK4Uz52m94Xb08noUpPwjSP+nx5l/
  mqQ/uo2/9rU2vqTTtNmKj7vuPvdyOp/EjPT0dyl0TK34zqNF7Hy28VVbt5+7pKJ2KKQ4rCHXC
  t+TFh3p+JcsipnupSl8ESRlH//ZAKbTKO8uwqc90aVZXsvun89fm//5cNfrNOcVhjvzT4iPiH
  1gv2hp/se/Z2QxGC40mztLf1jKQqH5/HInpabYa/EUpyRaKjFXFScCABUM9YrXwQAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-32.tower-655.messagelabs.com!1646761483!28706!1
X-Originating-IP: [104.47.26.43]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8359 invoked from network); 8 Mar 2022 17:44:44 -0000
Received: from mail-psaapc01lp2043.outbound.protection.outlook.com (HELO APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.43)
  by server-32.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Mar 2022 17:44:44 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyDcCW3BgEagUL9Lpo23wGdnNGR3wycFzXpor4Cs65M0ojAzXKngM1Q2FjCXQoaYmAZuBsCk8fhLIqWZKiyOBPnxmRFRotFeAKzowSAcWuRTBEjXxLaX7iXJ3khZH60J1/FM4JYP23sXW+oq+nPneDQYJ40jFYJr0HivknZeCEvCezkXXjks9EUYtgz0X6r/d72xURt7sG5c08qcJ/5FCGZgf7bJJGvhwQ6iP9W90DKdQWqXxwqsHvpZwfy4rJgZh7s1eeqCpCHqoRwNduyhOZYV7OrOrysJVqfz+q7t7j0D6uAfPcfi+YGH44TLM0T1IHgxhq0iSNSi/tQSlsFssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OneCfmyAMJ+sscG2+JxG1yBk+pc6LvR507y3ATkSa4=;
 b=D85RQeqaw/kLeS82l+EwlUhF+ivDcydcCIL6EP0F7ysQLwAbVRtFaQ6WBILiI79p7nffY2EKf3xdyBfSHiAHRSdXTa/chIjn157HInTwEBdB/BzJ+znYwm7szDlUW66TbkbJgGYx3ueD6+EZ1hSITD6wRSTnf4kDBlQntZPiyJaiUCBwq5aq/A8HsVdWiimIz8lUP/GbRzRYgTf3rOxlAPZ9D2yqiPt9L4ihHCbniJOjx2djbLa66v29bp7T7sx1hw/BQJ5N7G9NqpPuGQCR35/FIgAskG1Gy5oCgkAXr9/mxo1NXjLqunk4GsBKdwpIElxCwgQUZn9LPLikWm2FKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.7) smtp.rcpttodomain=redhat.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from SG2PR06CA0115.apcprd06.prod.outlook.com (2603:1096:1:1d::17) by
 HK2PR03MB4420.apcprd03.prod.outlook.com (2603:1096:202:26::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.17; Tue, 8 Mar 2022 17:44:42 +0000
Received: from SG2APC01FT0044.eop-APC01.prod.protection.outlook.com
 (2603:1096:1:1d:cafe::2) by SG2PR06CA0115.outlook.office365.com
 (2603:1096:1:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 17:44:42 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.7) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.7 as permitted sender)
Received: from mail.lenovo.com (104.232.225.7) by
 SG2APC01FT0044.mail.protection.outlook.com (10.13.36.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 17:44:41 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Tue, 8 Mar
 2022 12:44:39 -0500
Received: from [10.38.104.226] (10.38.104.226) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.21; Tue, 8 Mar
 2022 12:44:38 -0500
Message-ID: <2180533b-c921-5ae4-e6bc-569728a4f990@lenovo.com>
Date:   Tue, 8 Mar 2022 12:44:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
 <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.38.104.226]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3be94bba-dd5b-47ba-a048-08da012b5353
X-MS-TrafficTypeDiagnostic: HK2PR03MB4420:EE_
X-Microsoft-Antispam-PRVS: <HK2PR03MB4420332789967081E460AE79C5099@HK2PR03MB4420.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/VaP5kXsVuFVkn3p3ak2Y+uPj9muO4RHUTCk+b8YBC6VM5sROdifVeJsNL/n90TVeUzoxKlqao6XBOLM9JuP6aMvEV1Sp1AIOSgRzlfHxvlofFGcZqMQGg5LyZfvtn6p4j51p5DKGEvSwW2bgYSwom9uD20TJhcqr4U4do0Q0P9icnR0d1cYz/OW2pOd7W4lBU79kqdX8eZc3+KHAFROTpFR1bu4CfCKIAn/ri//BAHf2FHT2lJ9ZfTcx9eK00+jR413pZxBJdu8JQke3vt3Um/uYe74JJvE12qlVoTI4OAKWhGPE8kRARr2QFkYtgQZBejlix364kpStAnI17TiwD9tpx1D+rc8/AnD81hpbSCoRVjbWVbLL3RgJhD5xh0kBhh4XSkUw69Bp4mdjYBChBY6PXtuQCKWIhtp71mlVdNFMMxDmUzu5jIXlkSlS2VNI0pTlmMP4EJIrEgpZFACEVwqiiMl1kn/P564fKnUUQrL4WTcpG5753Y/YeOSkHqZ2ojh+YzRze13nEg9n+R8kH0W6RlhUa/Pu3rFEIva9y3xlfY892R1Sb0oyiISruDc27C+KgUVQPHiSiL8ZsgtSoxHn+B15kpPtaT8uPLVcXwa1FJgYzfYz2bsF4i5MV5GkaOBdOP2PmaWT7x+nb0dTh7S8ghpOQRK1qdawoMMtllztZeZwalDl6hN9t0JCc6WuVTkwbMDRI+fF6IvZM4ZujtmcJKZyWxoIZsRzCPemBkH801HJ1dLG/5Ufdu3NL9epWHI0tmyeOkVEGmf+Bc003tRovQUp0ZckgC3Obf16GZvJJwmaX5y++W33YnQv6o
X-Forefront-Antispam-Report: CIP:104.232.225.7;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.lenovo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(2906002)(47076005)(31686004)(82960400001)(110136005)(36906005)(2616005)(356005)(316002)(36860700001)(16576012)(36756003)(40460700003)(53546011)(31696002)(16526019)(508600001)(186003)(86362001)(83380400001)(26005)(4326008)(8676002)(82310400004)(54906003)(8936002)(70586007)(70206006)(426003)(336012)(5660300002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 17:44:41.4089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be94bba-dd5b-47ba-a048-08da012b5353
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203;Ip=[104.232.225.7];Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0044.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB4420
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Thanks Mario & Hans

On 2022-03-08 11:10, Hans de Goede wrote:
> Hi,
> 
> On 3/8/22 16:55, Limonciello, Mario wrote:
>> [AMD Official Use Only]
>>
>>>> I don't think that's right for the PSC Thinkpads.  They have dedicated
>>>> different tunings for each of the slider positions on AC vs DC.
>>>>
>>>> So "balanced" on AC will not be the same as "balanced" on DC.
>>>
>>> I see, but it is not like balanced on AC is closer to performance
>>> on DC then it is to balanced on DC, right? IOW in the UI we should
>>> still call them both balanced ?
>>
>> I feel that's a gross oversimplification to say balanced on AC is close
>> to performance on DC.  There are *so many* other (otherwise invisible)
>> tuning knobs behind what PSC does that Lenovo has weighed out the benefits
>> of using for different circumstances.  
>>
>> You nerf all this by just having one user space facing knob and let userspace
>> change to performance mode when you on charger.
> 
> The way I see this there are 2 ways this can work on the kernel to fw/ec
> boundary:
> 
> 1. There are actually 6 values we can write to a single slot:
>    ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-performance
> 
> 2. There are separate ac-setting + dc-setting slots to which we can
>    write one of 3 values: low-power, balanced, performance; and the fw/ec
>    automatically picks which slot to used based on ac vs battery status
> 
> If 1 is the case for PSC then I agree that the kernel should indeed get involved
> and it should automatically write either the ac or dc variant of the last
> userspace requested value so that things behave as expected.
> 
> If 2 however is the case then I think all that is necessary is for the
> driver to just write the last userspace selected value to both slots.
> 
> Note that neither case requires a userspace API change when solved
> as I suggest.

I cycled through a few different implementations but came down on what I
proposed. I considered 6 values - but I don't think that makes sense and
makes it overall more complicated than it needs to be and less flexible.

The biggest use case I can think of is that a user wants performance
when plugged in and power-save when unplugged; and they want that to
happen automatically.

This patch let's that happen for any platform - regardless of if it has
separate support. If a vendor wants to handle plugged in vs battery to a
more nuanced degree they can, but that's at the individual driver level.

I originally thought that maybe this should be done in user space but:

1) It takes a lot longer for user space changes to get rolled out and
make it into distros.

2) Not all users will get to use it - sure Gnome and KDE might get the
feature but chances of other desktops picking it up are small. I could
look at releasing a utility to do it but....urgh. Nobody gets a good
experience that way. Linux packaging is a minefield.

3) The power events happen in the kernel which is perfect. Once I
figured that out it seemed a no-brainer to me.

I think user space should add the ability to have a nice GUI to toggle a
unplugged profile setting. But the guts of it seem to me to belong
better in the kernel.

> 
>> At least the way Windows does this is that it offers "one" UI slider but you
>> have last selected values based on if you're plugged in or on battery.
>>
>> 1) So on battery I might have balanced selected to start out.
>> 2) Then I plug in a charger, and balanced is still selected but this has
>> different characteristics from balanced on battery.
>> 3) Now I change to performance while on charger.
>> 4) Then I unplug charger and it goes back to my selection for battery: "balanced".
> 
> The above is more about policy then it is about mechanism, userspace
> can easily remember 2 separate settings for ac vs battery and restore
> the last set value for ac or battery when changing between the 2.
> 
> Since this mostly about the policy which profile to set when this
> really belongs in userspace IMHO and solving this in userspace means that
> we will have a single universal solution for all the different
> platform_profile implementations, and we seem to have quite a lot of
> those (at least one per laptop vendor, Lenovo currently has 2)

I disagree here. This is more universal by design. I was surprised at
how many vendors are using platform-profiles (I think it's awesome!) but
now they can all get this too. The intention here is very strongly not
supposed to be Lenovo specific.

The follow on patch that I could do in thinkpad_acpi to use a different
setting in unplugged/plugged mode - that will be Lenovo specific and
taking advantage of the functionality the Lenovo FW is offering. That
doesn't seem unreasonable to me.

>>> If that is right then I think my point still stands, if PSC
>>> has 2 separate slots (one AC one DC) for the performance
>>> setting, then we can just set both when userspace selects a
>>> performance level and have the actual e.g. balanced -> performance
>>> change be done by userspace when userspace select the machine
>>> has been connected to a charger.
>>
>> But you *don't want to* actually select performance when you switch to a
>> charger.  If you have 3 value slots for AC and 3 value slots for DC you
>> should only be swapping between what is in those 3 values slots.
> 
> That only works if all implementation have separate AC and DC profile
> slots, which most won't have. If we just sync the 2 slots for implementations
> which do have 2 slots and then always "fake" 2 slots in userspace we
> have a universal implementation which will work well everywhere, without
> any significant downside to the implementations which do have 2 slots.
> 
I'm missing something in this bit. If a vendor is providing platform
profiles all we're doing is letting a user choose the profile they want
depending on their power situation. I don't think there are empty slots
particularly.

I've got a feeling I'm missing something obvious - but my experience of
user space is it's really hard to get a consistent experience for all
Linux users reliably - everybody is running something different.
If nothing else I think that should be a big factor for adding this
support to the kernel.

Obviously if this feature isn't wanted I'll drop it - but I think it's
something useful that users will appreciate on any HW.

Mark

