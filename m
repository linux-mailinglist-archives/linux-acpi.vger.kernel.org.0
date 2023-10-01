Return-Path: <linux-acpi+bounces-308-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32A77B46D9
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E001B1C208E3
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962215AC5
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Oct 2023 10:30:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C07CA31
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 08:56:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E265B4
	for <linux-acpi@vger.kernel.org>; Sun,  1 Oct 2023 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696150558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPE10IJGRNlrwSUAgF3AKhKtgeEbRkyMBAYmLJmNRH8=;
	b=PzXg+GOa0FEKWthdyUtGYDzb54osWPJI16w/eK49WvzeGs+hLunyQPvZLhVYWI9vOKV6VZ
	v4GdrGFURFs0xiuP80SAS5N0qZP657C6ox+1XUr9Gca2iuMyl6Mt2bEsporCgjs/PyjfuQ
	sKL1KURqbzxnSwO2NYptx+DnOVddJKs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-GmsfsLBrMiSxyRoF4ItAag-1; Sun, 01 Oct 2023 04:55:42 -0400
X-MC-Unique: GmsfsLBrMiSxyRoF4ItAag-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3231fceb811so9132607f8f.2
        for <linux-acpi@vger.kernel.org>; Sun, 01 Oct 2023 01:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696150541; x=1696755341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPE10IJGRNlrwSUAgF3AKhKtgeEbRkyMBAYmLJmNRH8=;
        b=kBYPj/qC/ddslylCtThfHun0x+DsKoKqGa7D+YyijpKLukWRYBJwJgYyk8wavRZf+y
         SFbfZUfBePU5ngBQs4mWgwAuyyRsAR372h9826NP8a26F1zN1qm6oAlHenbAN1P0416K
         KIXbKjeZIGTgOdN31JFKr69UN6BIFSeq8m3Z/s+wI+zt59DjGl0QgVkLerAU8r0xwc8D
         gJnlEq3CITJ6nqAcwO6c8L7D7/N1YuyNpKMiM0n4VAH8a3CtCGj19NZ7hv/pdRdX8jJn
         +foqqYZCUw1zHfot6IK2mvO6mBmFkvyjYJ71nLOzeChc/GP2k6ga9ibG3GTuO3REtKKt
         A2JA==
X-Gm-Message-State: AOJu0YwVvs8lMwK9YZnKy7GPPZh4vIlWgTAXQd5BqTUv8rMjUZa3yLWn
	zC9gvTqCeLT4a83Vt+PTK3fCEA+Rs1Vki6evxZqcEdNH/+irHGloUOqEsZhN6BO3gK401k245V2
	744p17tHEXFbNd7gGIbBWNQ==
X-Received: by 2002:a5d:610a:0:b0:314:1f1e:3a85 with SMTP id v10-20020a5d610a000000b003141f1e3a85mr6980697wrt.61.1696150541548;
        Sun, 01 Oct 2023 01:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSbH8Wg2khX9CeFAnrk0hxbXqrpe4hXgd+vt+57kWKXw4u/QLJ4vSOzdVhttX79b9XtDi9qw==
X-Received: by 2002:a5d:610a:0:b0:314:1f1e:3a85 with SMTP id v10-20020a5d610a000000b003141f1e3a85mr6980679wrt.61.1696150541268;
        Sun, 01 Oct 2023 01:55:41 -0700 (PDT)
Received: from [10.10.158.202] ([213.144.205.82])
        by smtp.gmail.com with ESMTPSA id t10-20020adff60a000000b0031c5e9c2ed7sm25367214wrp.92.2023.10.01.01.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 01:55:40 -0700 (PDT)
Message-ID: <b72b3fbf-36d1-2551-ac4a-f98808e1e4dd@redhat.com>
Date: Sun, 1 Oct 2023 10:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] platform/x86: int3472: Add new
 skl_int3472_gpiod_get_from_temp_lookup() helper
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Daniel Scally
 <djrscally@gmail.com>, Mark Gross <markgross@kernel.org>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <b8b1a3f0-3aca-341c-07ee-389b077a01f7@redhat.com>
 <ZRkw5FfhSq3J+Wb8@smile.fi.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZRkw5FfhSq3J+Wb8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/1/23 10:42, Andy Shevchenko wrote:
> On Thu, Sep 28, 2023 at 02:42:50PM +0200, Hans de Goede wrote:
>> Add a new skl_int3472_gpiod_get_from_temp_lookup() helper.
>>
>> This is a preparation patch for removing usage of the deprecated
>> gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> [hdegoede@redhat.com] use the new skl_int3472_fill_gpiod_lookup() helper
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Something wrong between authorship and committer and SoB chain.
> I believe you need to preserve the authorship and add yourself as
> Co-developed-by: ?

Yes you are correct, I'll prepare a new version of the series
with this fixed.

Regards,

hans



