Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F274E7B5C
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 22:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbfJ1Vcz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 17:32:55 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57800 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfJ1Vcy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 17:32:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 8A113955
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 21:32:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OcXzabFfTqeS for <linux-acpi@vger.kernel.org>;
        Mon, 28 Oct 2019 16:32:53 -0500 (CDT)
Received: from mail-yw1-f69.google.com (mail-yw1-f69.google.com [209.85.161.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 638D196D
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 16:32:53 -0500 (CDT)
Received: by mail-yw1-f69.google.com with SMTP id b184so7582695ywa.15
        for <linux-acpi@vger.kernel.org>; Mon, 28 Oct 2019 14:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uDrG/QB1ocWufg3nTBk8YzO1SgTVOLO8yEVFY7noWh8=;
        b=c+7MiJORtn3YKb0mSwFTeEdXKtUvilRAKh1VTFbPkjpMdl+mV5jBttjErVuEGc/++L
         9dtSRGlmYbeHgdugfIOqHAGoo+Fvx6HKJpKe42hIw1gcETN53H2G5T4x91xcMfbEYdxP
         nEZ6L8OBNzQyXgazjtC3z325Xx++ypQpvh1R3C+ioAulRptUTjZu1qG7CJkBZBONlSuv
         kUvqAp8VOvSQP9jAv4/SAEBjpXPODp6OlChhR5IBRA+29D6Z75qIdbHLOsPNxsm4USm2
         4RkcGEWIbdAg2yqA06Ti99bR9/ySmFsyftr01BcF2KhBp4OnH/LAgSp9OZLm8HLtWk9c
         LXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uDrG/QB1ocWufg3nTBk8YzO1SgTVOLO8yEVFY7noWh8=;
        b=nPCPyiGBJqhX2e7ANM3nnF109IAbajlgHjBxR+JI8oEwfdGl7hr4Oi4HyCYW+2YFxT
         1NauOTU/BV73rYRuM+ssdfwnOd1F0DsFfejQb3RshUS/tDvob8/ssaVe9+TIb8hmqSil
         wiMJEuTVIAo732sVR1nS+Pd9FE0tT2F7QfjBAaHFiQGaFaJSDAtyzBdbWKUI6lFy6Pq+
         4YlTRdBhalvIMm38PsK2apzZ+U775mYBB3j1bDYNeFrJ8eQIYAiQziCWoLMtyu4ZM6QD
         qZ5/bW71upI/vHOUEEd2N3wxvxTv3qf3em5WrhbBnrhJm6HawwCYu8mUheDortalQ8l7
         /CIQ==
X-Gm-Message-State: APjAAAVcdf41NjzOiIpt3/LD89BLH02ofDNzCvkCiRN+gzFlWGoauG1r
        ObPFwRj3+zesvEyClSXVHcdUaQfpSJnkK2ifhN+A9+GcqasvIq5ZYTbC1BYwLD0eGuC1IjSj7lm
        CTjJCJLe5qzssGqpaAykjCmvRWg==
X-Received: by 2002:a25:6e86:: with SMTP id j128mr16049089ybc.456.1572298372542;
        Mon, 28 Oct 2019 14:32:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySBqBnJ6JLt6df17vvOfF0xSZaO8QeQoR74n0y49rqiBCzuspIHKzsSa1ZGSaIKuCPe3RtKw==
X-Received: by 2002:a25:6e86:: with SMTP id j128mr16049055ybc.456.1572298371957;
        Mon, 28 Oct 2019 14:32:51 -0700 (PDT)
Received: from [10.21.9.107] ([173.46.66.82])
        by smtp.gmail.com with ESMTPSA id 203sm6083714ywp.76.2019.10.28.14.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 14:32:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH] acpi: fix potential race conditions bypassing checks
From:   Kangjie Lu <kjlu@umn.edu>
In-Reply-To: <3605712.hsAW26GfSv@kreacher>
Date:   Mon, 28 Oct 2019 17:32:26 -0400
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3AEC2592-C58F-4E27-9C12-0C6E92136F5C@umn.edu>
References: <20191028183114.15709-1-kjlu@umn.edu>
 <3605712.hsAW26GfSv@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> On Oct 28, 2019, at 4:51 PM, Rafael J. Wysocki <rjw@rjwysocki.net> =
wrote:
>=20
> On Monday, October 28, 2019 7:31:14 PM CET Kangjie Lu wrote:
>> "obj" is a local variable. Elements are deep-copied from external
>> package to obj and security-checked. The original code is
>> seemingly fine; however, compilers optimize the deep copies into
>> shallow copies, introducing potential race conditions. For
>> example, the checks for type and length may be bypassed.
>=20
> How exactly?
>=20
> What compiler(s) do such optimizations in this particular case?

Tested on LLVM. The deep copy is indeed optimized into a shallow copy at =
optimization level O2.


>=20
>> The fix tells compilers to not optimize the deep copy by inserting
>> "volatile".
>=20
> Have you actually analyzed the object code produced by the compiler =
with and
> without the volatile to determine whether or not it has an effect as =
expected
> on code generation?

Yes, with =E2=80=9Cvolatile", the deep copy is preserved, and =E2=80=9Cobj=
=E2=80=9D is created as a local variable.

>=20
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
>> ---
>> drivers/acpi/processor_throttling.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/acpi/processor_throttling.c =
b/drivers/acpi/processor_throttling.c
>> index 532a1ae3595a..6f4d86f8a9ce 100644
>> --- a/drivers/acpi/processor_throttling.c
>> +++ b/drivers/acpi/processor_throttling.c
>> @@ -413,7 +413,7 @@ static int =
acpi_processor_get_throttling_control(struct acpi_processor *pr)
>> 	acpi_status status =3D 0;
>> 	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
>> 	union acpi_object *ptc =3D NULL;
>> -	union acpi_object obj =3D { 0 };
>> +	volatile union acpi_object obj =3D { 0 };
>> 	struct acpi_processor_throttling *throttling;
>>=20
>> 	status =3D acpi_evaluate_object(pr->handle, "_PTC", NULL, =
&buffer);
>>=20
>=20
>=20
>=20
>=20

