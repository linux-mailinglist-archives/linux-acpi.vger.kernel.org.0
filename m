Return-Path: <linux-acpi+bounces-662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E5A7CAFF8
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D888F2817E7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFCC30F90
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5YI0DAg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F789286BC
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 15:34:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320DB4
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697470459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPRhpPC18KaMGaT72RRJQ/JKOBjEh62LPYtBWm6lGZQ=;
	b=b5YI0DAgAnI6wzxfdFaCVhImTfTXi7N89MGjsHs4AQWY2kbIkkLDN5/p9L7SmLrWdTssul
	FxpmssfsPgFWjvlUjuQGIgMYPYj68DHkBKH7FHFpXCUwDv+HnGUICAkIoNlUQwZb+TYEij
	pZy21N4FF4Gict4oy+vWbiW7KkqdD9o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-RWWfMERRN1GMEGuEIJVaxA-1; Mon, 16 Oct 2023 11:34:13 -0400
X-MC-Unique: RWWfMERRN1GMEGuEIJVaxA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae0bf9c0b4so353907866b.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 08:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470452; x=1698075252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPRhpPC18KaMGaT72RRJQ/JKOBjEh62LPYtBWm6lGZQ=;
        b=tsxZv4CjqsL+00LV28846CDcw6+4SaNkNo8v0omeWfaCbQYbkENEL2eKUOSe4rQN67
         yF6cRWhiavwNVVhACFBmxGpOrj6lZWsnOPxP72iYiq0qO1gyz8zf6JzzQVQ+XRZD7k+F
         0twwBseH9s98nBylCQ8t/QE/zXev9Y0nJALYtEQOjNAm2YJ+q6ZFwrrxaEn7697bwJAn
         iPBVR0qUInrG5VKky7iq7iU3sAMiv7l5raz/IvRZGEU/sfaFHScxrCynq8jOuQbWQ3Mj
         egEnDTohKw14KWqkLbobmosxLcenMdlYUaecrJk8ILsJLE62jqyM2Ih+dHC/uYdYDD/l
         wzoQ==
X-Gm-Message-State: AOJu0YzgUe8xFV/mLHW3zl7jOVJLQcw5mhSGMY04LTui5vcrHk9uL9rT
	NZ5tSnA6JTDf2yziwhob8uMhKHOaNUY5UXhASsx8Xd+2YoVsYTWbSnhb7Qv7XBtJCyclgaYWNww
	YyaRJ+PckmlqF2cegesoMyA==
X-Received: by 2002:a17:906:7949:b0:9bd:ff07:a58a with SMTP id l9-20020a170906794900b009bdff07a58amr7765767ejo.53.1697470452096;
        Mon, 16 Oct 2023 08:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7c5VXHjpz6kDDov4qHMw6C/Oj6MjxdvABy2uuy5M+drjyXqut4Nr8/fIvCZH9LvhdZmXptA==
X-Received: by 2002:a17:906:7949:b0:9bd:ff07:a58a with SMTP id l9-20020a170906794900b009bdff07a58amr7765756ejo.53.1697470451787;
        Mon, 16 Oct 2023 08:34:11 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id dk6-20020a170906f0c600b009c3827134e5sm2641958ejb.117.2023.10.16.08.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 08:34:11 -0700 (PDT)
Message-ID: <7d3f0ecc-bbd7-41c3-413b-c024563e2941@redhat.com>
Date: Mon, 16 Oct 2023 17:34:10 +0200
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
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-spi@vger.kernel.org
References: <20231014205314.59333-1-hdegoede@redhat.com>
 <20231014205314.59333-5-hdegoede@redhat.com>
 <5d777654-4700-46ad-bec2-3921d0b7d0fc@sirena.org.uk>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <5d777654-4700-46ad-bec2-3921d0b7d0fc@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/16/23 16:47, Mark Brown wrote:
> On Sat, Oct 14, 2023 at 10:53:14PM +0200, Hans de Goede wrote:
> 
>> +	.micd_force_micbias = 1,
>> +	.micd_configs = lenovo_yt3_wm5102_micd_config,
>> +	.num_micd_configs = ARRAY_SIZE(lenovo_yt3_wm5102_micd_config),
>> +        .micbias={
>> +           [0]={ /*MICBIAS1*/
>> +                 .mV =2800 ,
>> +                 .ext_cap=1,
> 
> The indentation of this section seems weird - .micbias is indented and
> the lack of spaces around =s is odd.  There's also an extra space before
> the , consistently on the mV lines.

Right this is a copy and paste fail on my side, I've fixed this up
locally already, so this will be fixed in the next version.

Regards,

Hans



