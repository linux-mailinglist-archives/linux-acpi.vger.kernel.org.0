Return-Path: <linux-acpi+bounces-679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5787CB2CA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 20:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458B6280F98
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C134182
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Oct 2023 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+G4IGCX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046E34197
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 18:38:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8307495
	for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697481508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zs+lHskTeTS1TcsvMpv41AYJj/qLk+4rSlBCHgXCWvc=;
	b=f+G4IGCX/0LOXDW3SYXXSLJHHVHRRe5+AV5hkBfyWoBEekmWBDWTdwtakwKcXxNUPRZeUM
	lPXAMrw8Cu2+YAW1Xb3TJIRkzKvTmcVwkhCd1Hansq60rYa2JPGsaqOdRdSwKYUZFsk2A2
	zDlX7ShmQOJmyeyyF/5msVD6yZl8xXw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-u8bs7r-SN1mT4EIq778ajw-1; Mon, 16 Oct 2023 14:38:22 -0400
X-MC-Unique: u8bs7r-SN1mT4EIq778ajw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae686dafedso351615966b.3
        for <linux-acpi@vger.kernel.org>; Mon, 16 Oct 2023 11:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697481500; x=1698086300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zs+lHskTeTS1TcsvMpv41AYJj/qLk+4rSlBCHgXCWvc=;
        b=hrplXDLlH2Tfobbohk4tLo3uIN1OaSm5GDzZ8UKmCROF210qAW/duZp1un3EStT0oQ
         JMGfYSn3MjHq4RrrToYG26gqRkeZrK30pxbPgm8sCJEt3mAnIz7glEhHub2YgQnw+CT1
         uMQOJx/HM8CuL+NSeSfW0BXKnhR3LrOrofGDTPrBVl9nlut6oTHf6BefCG3QbFilYhGy
         y9l7J92B/7+MUmQTspqmgmoyBiQXbVYhyOzIkqfB5W4ErfOVuWp3QKn8Hq9Yfrc6XLa6
         O/aExjiOfmd3yjPKVj8RmmBkkU2x3Y/1/0YF5q9ciZYbYIFYnxzDCTAmO/tk1Ae537eo
         qsag==
X-Gm-Message-State: AOJu0Yyyh8v71tg2Pc1KDZzfD16iZw7sCk5Kd364s0hmMXdpXXBf2vRa
	Of5f6dp26BIleKxAdWAWk0snaRYGwmjBvPLKX5kvufLsqBlCm6dy2d5oRBpEGWuzfyju8WiinBg
	mziyldox+pEAQJjxsSEej01N7P7Kc+Q==
X-Received: by 2002:a17:907:3e21:b0:9c3:bd63:4245 with SMTP id hp33-20020a1709073e2100b009c3bd634245mr4522960ejc.47.1697481500693;
        Mon, 16 Oct 2023 11:38:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH+jj7O1f0tpsiiEeDbkTbIvsIwBY4dqV1bDh+UI49K/oX5NoNQC7BVLjRgvfyHSwPJIczZw==
X-Received: by 2002:a17:907:3e21:b0:9c3:bd63:4245 with SMTP id hp33-20020a1709073e2100b009c3bd634245mr4522945ejc.47.1697481500498;
        Mon, 16 Oct 2023 11:38:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id nc30-20020a1709071c1e00b009b65a834dd6sm4476471ejc.215.2023.10.16.11.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 11:38:19 -0700 (PDT)
Message-ID: <1c5b051e-8ee2-6f61-dc18-3c6f75b428d5@redhat.com>
Date: Mon, 16 Oct 2023 20:38:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] ACPI: resource: Do IRQ override on TongFang GMxXGxx
Content-Language: en-US, nl
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Werner Sembach <wse@tuxedocomputers.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231016160828.373599-1-wse@tuxedocomputers.com>
 <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0itvrL7ijh07kB6i6o0ShCboWhv+09Gzo299DLK+GkH1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 10/16/23 19:33, Rafael J. Wysocki wrote:
> On Mon, Oct 16, 2023 at 6:08 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>>
>> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
>> for the keyboard to work. Adding an entry for this laptop to the
>> override_table makes the internal keyboard functional.
>>
>> v2: Rebase onto linux-next
> 
> Hans, any comments?

No comments, the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> 
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
>> ---
>>  drivers/acpi/resource.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 18f6353c142e..15a3bdbd0755 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -497,6 +497,18 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
>>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>>                 },
>>         },
>> +       {
>> +               /* TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
>> +               },
>> +       },
>> +       {
>> +               /* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
>> +               },
>> +       },
>>         {
>>                 /* MAINGEAR Vector Pro 2 15 */
>>                 .matches = {
>> --
>> 2.34.1
>>
> 


