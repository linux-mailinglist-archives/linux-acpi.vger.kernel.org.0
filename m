Return-Path: <linux-acpi+bounces-532-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AB7BDC1D
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 14:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDD21C20852
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 12:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37355171AE
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Oct 2023 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgilhPJt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68699BA51
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 12:10:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3E7AB
	for <linux-acpi@vger.kernel.org>; Mon,  9 Oct 2023 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696853433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIyRfHkAIwuGp8hT7eJUs9lEr3357JAlgogvvefitEQ=;
	b=MgilhPJtWigxOSG3Y2C8TtMM1DU+3STEVIa4H7DtWxRGDmC/3HXnsEMTcFkZPnqfhkyxYV
	TKEfA4SIPBSnD5+OfTi4VfenuKEpTlunBSXVtHg3XSQActgc9/LkEQ6E1RyRAUm1tWsF0D
	eSDPtGO/Kw5e9lGhNY5WAt0AcGzD0bU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-gnwRqGJSP_qWzi_s_3dMjA-1; Mon, 09 Oct 2023 08:10:32 -0400
X-MC-Unique: gnwRqGJSP_qWzi_s_3dMjA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99bcb13d8ddso108858766b.0
        for <linux-acpi@vger.kernel.org>; Mon, 09 Oct 2023 05:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696853431; x=1697458231;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iIyRfHkAIwuGp8hT7eJUs9lEr3357JAlgogvvefitEQ=;
        b=aum96/Os4Ygwo0i7+BlEuKRGpg7gM66AU7Uj4sTPvufUBRlcMTxVOp9pLPZFz3StPL
         ZxFmoPWwy99j43rNXx5bInncmPb+c1tSgFW8sz3tz93BvAI0xbb0pEDS2fR0+SNLrAOl
         Vzw5rT63Oi2Fmsow2nIG6EwD5Hmlkd8kJLw3/776IWmLMleYcKTRqZVkC9e2p7FjzwnI
         yynl1mocTojF3FFKPLE16jbmcwAEZENQVlRFrRzDUj+3rHKl+vYC2RJHVV6ywOINA6Pj
         Dyxmd4cHoYaftuaoIfiGOYWXRQCGsuQHxZDt83xdAWNJw9U0xx8p66iFvEW9HCZaX9vb
         IfnA==
X-Gm-Message-State: AOJu0YwL6OwfHuPhu9GvSjqlEOHG0WT9aPcjVW+PIidAzWQjvsIU6Dc1
	PvGsWTVZXqtgnZfNF2PLh2DosesNetTUWwObLUTyirQJr1rRBHOiBbonG4VxED0oRY2HdHilifB
	Tf7dGhS/OM2aqruvH9noExw==
X-Received: by 2002:a17:906:31d6:b0:9ae:699d:8a2a with SMTP id f22-20020a17090631d600b009ae699d8a2amr12596496ejf.5.1696853431228;
        Mon, 09 Oct 2023 05:10:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAs2cz5PFcqOiVeADiguilbVRbiXu0RYwZqXR7dkdNNPyY+w89VIgJhQXj62aoIIXCj14xKA==
X-Received: by 2002:a17:906:31d6:b0:9ae:699d:8a2a with SMTP id f22-20020a17090631d600b009ae699d8a2amr12596485ejf.5.1696853430876;
        Mon, 09 Oct 2023 05:10:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id l7-20020a170906a40700b009ae587ce133sm6688268ejz.188.2023.10.09.05.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 05:10:30 -0700 (PDT)
Message-ID: <f8864b1d-9e66-6f20-ca2f-cc869b427343@redhat.com>
Date: Mon, 9 Oct 2023 14:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and
 GM6BG0Q to irq1_edge_low_force_override[]
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: August Wikerfors <git@augustwikerfors.se>,
 Mario Limonciello <Mario.Limonciello@amd.com>, linux-acpi@vger.kernel.org,
 Francesco <f.littarru@outlook.com>, regressions@lists.linux.dev
References: <20231006123304.32686-1-hdegoede@redhat.com>
 <ed4672a7-439c-4240-aadc-7a36858c36b2@augustwikerfors.se>
 <9a905931-6210-8f6b-92f5-3c863d4a2e86@redhat.com>
 <CAJZ5v0gK1Q54sMRJJJBTf+gY5jd-_57jYKvN5ELNSpmaeVVjAw@mail.gmail.com>
 <026f8034-0b0e-9c77-f547-7f883b9b8bc1@redhat.com>
 <CAJZ5v0gYc7OePFzLLA2NTEzRy1DU+L86gE80vtBT6Jz4DBO1nA@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gYc7OePFzLLA2NTEzRy1DU+L86gE80vtBT6Jz4DBO1nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/8/23 14:16, Rafael J. Wysocki wrote:
> On Sat, Oct 7, 2023 at 10:51 AM Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>> I realize that I'm the architect of this whole mess, but delaying
>> these new quirks to 6.7 does not seem like a good idea to me.
>>
>> This fixes a serious problem (kbd not working pretty much makes
>> the whole laptop unusable under Linux at least on the road). With
>> a very small chance of regressions since this is DMI match base.
>>
>> Maybe we can just take all the resource.c DMI quirk changes
>> as fixes to 6.6 ?  I admit the:
>>
>> "ACPI: resource: Consolidate IRQ trigger-type override DMI tables"
>> "ACPI: resource: Drop .ident values from dmi_system_id tables"
>>
>> patches are not really bugfixes. But they too have a very low
>> chance of causing regressions.
>>
>> Regards,
>>
>> Hans
>>
>>
>> p.s.
>>
>> Note that "ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA"
>> should probably go as a fix to 6.6 regardless of the discussion since
>> that is a pure bugfix which applies cleanly on top of 6.6
> 
> That can be done.

Great thank you.

>> And the same goes for this (unrelated) drivers/acpi/ec.c patch:
>>
>> "ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx"
> 
> That can be done too.

Thank you again.

>> That too is a pure bugfix which IMHO should go to 6.6 as such.
> 
> But if you want the $subject patch to go into 6.6-rc, please rebase it
> on top of the latest 6.6-rc and resubmit.  It will not apply cleanly
> on top of the current linux-next, but I can handle the merge conflict.

That works for me, thank yuo. I've prepared a v3 which is based on
v6.6-rc1 so that it should apply cleanly for merging as fix for v6.6.

I'll send v3 out right after this email.

Regards,

Hans




