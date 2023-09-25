Return-Path: <linux-acpi+bounces-79-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63507AD602
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 12:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 857E1282968
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F6315E98
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 10:31:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9081097B
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 08:58:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA7101
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695632280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9jYoDjvuIiF2NPGNNFR7POpOKaph301yFE9PJUJP/aA=;
	b=fCimPoqy1XdpgxlA7aUyWSK8RSlObGiHYSVJ95Oeecj5+0SATVu9SBVwjKeTXMRWhOLjIp
	TVeXlNlHPolRsx/3v9ORMdcFEWlBiNryRaVDhZM9ZRmtsNiDRm8YrwmiyfCiAKcdzI01Df
	pLLmO6VrwIspWdcYiHBmuIOc/xebiXw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-GxITwU3BMiKqLEa9ynsqIw-1; Mon, 25 Sep 2023 04:57:59 -0400
X-MC-Unique: GxITwU3BMiKqLEa9ynsqIw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-533d8e03793so1904404a12.3
        for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 01:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695632278; x=1696237078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jYoDjvuIiF2NPGNNFR7POpOKaph301yFE9PJUJP/aA=;
        b=dSUeDq9OumPC1gqhd1wN6NnNGxKdcsDP/gq+xO9onQrPIpYMuvSzyExLMsc3cPYyHa
         53VRd4dfhLPpNr37B1bEosvdnQ9DJMvKRRNw5AJ20kTvdPrrLiWAtitsMrZUF7ywNppr
         MK/QhtzhEV2iFE9HNFFh0IN4bvfOeBQ/Cjr1qG4vCBZgIAmcoWCt6cA1aG9Dl8FOkaLj
         B6UqIiWMJLKkhucu9ofbAjlMvoQ2JvrnqymvmDfqWFB3MwKef+Zg8K867vaHdonBernY
         b71tZk1861BZuZWLOE03Q1+CpH0fZ+ksHmFRTRtxofDIiTcfmHcIaUm2N4T5K2/8mZHN
         zJ4w==
X-Gm-Message-State: AOJu0YxPWlg4FI0U6lnYpxuLymV1mjlHZhcLyQnEA3VHosxMbNZaDPly
	vIeoycR6qcZ4cismtjpHm8FVU6NsYcyAxHmGa5Vf/e5eWh6Zu6xEkz2FVYZ/GkbCAHvCJ2D6s/t
	L7LhIYw3bXNWzAG3qjish5Q==
X-Received: by 2002:aa7:d7d4:0:b0:52f:a42a:85a3 with SMTP id e20-20020aa7d7d4000000b0052fa42a85a3mr5145193eds.0.1695632278258;
        Mon, 25 Sep 2023 01:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWi9IMy9qmd+fxRBkEfI4zNh3gSWBYXC8dXmPklh/1AUGyK3RZVi4CUBMQfEKDMBdqZ0ZdKg==
X-Received: by 2002:aa7:d7d4:0:b0:52f:a42a:85a3 with SMTP id e20-20020aa7d7d4000000b0052fa42a85a3mr5145189eds.0.1695632277950;
        Mon, 25 Sep 2023 01:57:57 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.149.50])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640206d200b005224d960e66sm5201641edy.96.2023.09.25.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:57:55 -0700 (PDT)
Message-ID: <74ad10fa-f0f6-f80f-7db3-fb01aae6f2d5@redhat.com>
Date: Mon, 25 Sep 2023 10:57:52 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in
 platform_profile_show()
To: Jiri Slaby <jirislaby@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, hmh@hmh.eng.br,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
 <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
 <beeab87b-820a-475a-b0c6-99b1b8e491ea@kernel.org>
 <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

+Cc Mark Pearson for thinkpad_acpi dytc support

Jiri,

On 9/25/23 09:38, Jiri Slaby wrote:
> On 25. 09. 23, 9:19, Jiri Slaby wrote:
>> But convert_dytc_to_profile() doesn't handle this at all. Do I have a newer DYTC interface? Or a broken one?
> 
>                 Case (0x00)
>                 {
>                     Local1 = 0x0100
>                     Local1 |= 0x80000000
>                     Local1 |= 0x00
>                     Local1 |= 0x01
>                 }
> 
> I.e. version 8.0, it seems.
> 
> Full DSDT for reference:
> https://decibel.fi.muni.cz/~xslaby/n/DSDT.dsl

Mark, can you please take a look at this (it is a thinkpad_acpi dytc issue)?

Jiri, Thank you for all the debugging you have done on this. Can you please file
a bug with the details / summary here:

https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers

Using Platform_x86 as component so that Mark has all the info in one place ?


Regards,

Hans

p.s.

Mark, maybe should add you to the MAINTAINERS section for thinkpad_acpi ?


