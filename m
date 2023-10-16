Return-Path: <linux-acpi+bounces-659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F497CA5EF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6B1B20CF4
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C41321101
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5vCG43Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6DE1A29F
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 08:59:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7368FAB
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697446752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciQpvb8toJic6WpPKRE/AeagKH9fiYHBE+ZhRFvm5DI=;
	b=E5vCG43QcheOzOyL3hdyVvel+UQLNmYoZM/iWqB3dodiSuwFqA5uRYCX2A+kQ3dgIMaxsi
	cUZeHWlZXRSbpmhGJyy+4JxU/VCvwqn/FeBXo26RfAP35hy6wh6mMN1+4k3ISmC/R1hUZJ
	J3frmuU7IRNIlppE6p5+c6m8MGzr8ns=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-T9q9XAJoOdi8m45G12m4OQ-1; Mon, 16 Oct 2023 04:59:01 -0400
X-MC-Unique: T9q9XAJoOdi8m45G12m4OQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b65c46bca8so21995766b.1
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 01:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697446739; x=1698051539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciQpvb8toJic6WpPKRE/AeagKH9fiYHBE+ZhRFvm5DI=;
        b=lpbY+QG/VoCSFcivz4r00ZAmkttB6Pe89rTOcLkg2XraNPjvziTqoFcxQe9uXQAfBw
         qanJRmVZ+J2yhIEnaBUOSQqSSsEjskrzYESnimSE0rLOsgSPiPMWgENA1kzQpb4TKZ4P
         FEpaKOcldB7mEnQJJYkjYqKOIAAWE+GG3nTVmh54p70k0t7k+GJ/DqVkenJMHu513zN/
         rmVBNfW8U+jpG1ZV+wF3vu0fG9iV7wo3nqrxB2p9MobpY7rvzDw0RzSTCFQwcTfXp84w
         IowV5o9I+344+B82L5o0OrsHlGS7Hr38EIPnJnugtoUj3zxnb/tQrL0QsQy4ZDDaesDG
         0BOA==
X-Gm-Message-State: AOJu0YxI3uofBZ964eW+1AalIXGW/Bc6/8FvbMNxsELA8WUG3riexuBc
	vIOf/2iQWDoTiR5YX+BOpYgiQhUdAlmCe5mscs3kdbHf/zKKmUi19igxOReauNxVrm/0JEFYYej
	GNiJyRcLKQU711oMZCR9img==
X-Received: by 2002:a17:907:1c25:b0:9bf:b022:dc7 with SMTP id nc37-20020a1709071c2500b009bfb0220dc7mr3798572ejc.48.1697446739775;
        Mon, 16 Oct 2023 01:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0iTatvUyost5Hu3jUWmmtCCHZ34EkgvvWD43IwKXRJbTUeU4xoMjyb1HS9ASazaT5JYUKpg==
X-Received: by 2002:a17:907:1c25:b0:9bf:b022:dc7 with SMTP id nc37-20020a1709071c2500b009bfb0220dc7mr3798561ejc.48.1697446739511;
        Mon, 16 Oct 2023 01:58:59 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g7-20020a170906198700b00992b8d56f3asm3616538ejd.105.2023.10.16.01.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 01:58:59 -0700 (PDT)
Message-ID: <de3145e8-3d76-63af-e018-26b7ad1aca75@redhat.com>
Date: Mon, 16 Oct 2023 10:58:57 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] platform/x86: x86-android-tablets: Add audio codec
 info for Lenovo Yoga Tab 3 Pro YT3-X90F
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
 <65cb8c8c-1a07-922b-db7a-dba54afc76b6@redhat.com>
 <ZSzwslha2aUGod7A@smile.fi.intel.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZSzwslha2aUGod7A@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/16/23 10:13, Andy Shevchenko wrote:
> On Sun, Oct 15, 2023 at 11:15:47AM +0200, Hans de Goede wrote:
>> On 10/14/23 22:53, Hans de Goede wrote:
> 
>>> +        .micbias={
>>> +           [0]={ /*MICBIAS1*/
> 
> Talking about spaces, how about
> 
>         .micbias = {
>            [0] = { / *MICBIAS1 */
>                  .mV = 2800 ,
>                  .ext_cap = 1,
>                  .discharge = 1 ,
>                  .soft_start = 0,
>                  .bypass = 0,

Ack, I already have it like this locally now. Also using only
tabs, there is plenty of width to just indent the "[0] = { ..."
with a tab too.

Regards,

Hans


