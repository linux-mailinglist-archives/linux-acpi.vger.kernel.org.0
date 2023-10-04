Return-Path: <linux-acpi+bounces-411-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D617B7D37
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 12:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id BF9201C2081F
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF56111A2
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Oct 2023 10:33:00 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE810A0B
	for <linux-acpi@vger.kernel.org>; Wed,  4 Oct 2023 09:38:06 +0000 (UTC)
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7ACBB;
	Wed,  4 Oct 2023 02:38:04 -0700 (PDT)
Received: from [192.168.42.20] (unknown [91.22.66.69])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id D0AF02FC0010;
	Wed,  4 Oct 2023 11:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1696412282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EHI8fHLnGoVd2F2Ocb2wELrRiN7lJQWOBGnepKa2sM=;
	b=HeIJy8femgJ2hQmkH3yfw7h1BlAmQrTVdUZFsPT4vK/KN3okjt+Dk5xXHaBerYgQ8/jTg0
	wn8h0uA/vev4YGP05v8/BSfMZFaOIDsM1yhXtSc1M5Ryn/ClJENEnrU++eOKwchB7clOsj
	gGBikXsCqGLOl5uCmpO3EuygaoaQ6ac=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <5d82fcac-a360-2d8b-8f6a-9b5cecb08ca2@tuxedocomputers.com>
Date: Wed, 4 Oct 2023 11:38:02 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230929134010.25644-1-wse@tuxedocomputers.com>
 <CAJZ5v0iH4PGaCdSuQ-4Pu7oXbzrw+zLxpEqMjtMgcNFextgfqw@mail.gmail.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <CAJZ5v0iH4PGaCdSuQ-4Pu7oXbzrw+zLxpEqMjtMgcNFextgfqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

Am 03.10.23 um 20:39 schrieb Rafael J. Wysocki:
> On Fri, Sep 29, 2023 at 3:40 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
>> for the keyboard to work. Adding an entry for this laptop to the
>> override_table makes the internal keyboard functional again.
> You said "again", so it used to work.  Do you know which commit broke it?

Sorry that "again" is a bit misleading. I Copied it from here: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7592b79ba4a9

I actually only tested the direct predecessor of this Notebook on older kernels: 
https://bugzilla.kernel.org/show_bug.cgi?id=216698

I suspected that it's the same issue and since the same fix worked I now even 
more believe so, but I actually never tested a kernel before the breaking change.

>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> Cc: <stable@vger.kernel.org>
> What's the oldest kernel version you want this to be applied to?

5.15 because Ubuntu 22.04

Kind regards,

Werner Sembach

>
>> ---
>>   drivers/acpi/resource.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 32cfa3f4efd3d..3aff81820e321 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -470,13 +470,25 @@ static const struct dmi_system_id asus_laptop[] = {
>>          { }
>>   };
>>
>> -static const struct dmi_system_id tongfang_gm_rg[] = {
>> +static const struct dmi_system_id tongfang_gm[] = {
>>          {
>>                  .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>>                  .matches = {
>>                          DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>>                  },
>>          },
>> +       {
>> +               .ident = "TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
>> +               },
>> +       },
>> +       {
>> +               .ident = "TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
>> +               },
>> +       },
>>          { }
>>   };
>>
>> @@ -536,7 +548,7 @@ struct irq_override_cmp {
>>   static const struct irq_override_cmp override_table[] = {
>>          { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>          { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>> -       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>> +       { tongfang_gm, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>          { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>          { pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>>          { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>> --
>> 2.34.1
>>

