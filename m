Return-Path: <linux-acpi+bounces-18018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8792BF4F92
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EFF4633EE
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 07:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88121CC60;
	Tue, 21 Oct 2025 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/OsHNjx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A99246762
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761031928; cv=none; b=koCDDy9u0I+Uj6OeXZXVS1mZNFTkYxaEzjZ9GUQnUhsXM3dG+R0Usd7uuQpIS6zxEl45pTIDX5qopOnc4cMagyqqSK5qYA5TixkvZ+N8TvR4a6jGHT4f9YuCA7zrZ/MSvMU4lT7XhFyqMMcf72Y8CMpVU7ZvjdUv8DxooNAL7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761031928; c=relaxed/simple;
	bh=MZ9jjV6RD/JyPApchpDTq6E8TDeTqu1FHrxJ0c/RcWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzertOrVy0d8hwGgQW52Ttbo2CIkgombSL1ndpQ7lmZBN5ZorFJQAZnk2T/brVx0RlTuaPK2itjrfkz22C3FeRNVjzVvcScbleO/6RsCfYR3fRP62N0+8I1yFfojwYS0W/yHYtEL68y3QP5ynnUbJr28v6AMaF8vX1sZy3gC/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/OsHNjx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7848f763982so35140457b3.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761031926; x=1761636726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80GPaLt8RJEs0Dy2pPxjPW4aTwa88xJPXSCXcH5OIhw=;
        b=g/OsHNjxss6+9UgGKxyXGq16wMIlM+4Wc7CIyL+OtbSL4T+qdrRwrZuFZgesVkfMBA
         Cjo6W3EIJOspqFZc0dbdxnPzHktI39zekqBVCWHjCbFEpni7kKXtI+hbtoGtzVNJqXRU
         L+Z2gd8MGc8GPcudo5+o9c7ucqRK6cfGTQY/zRlVP4qaDpTPFyw0xfuoak7QkHwLSIcp
         ll8uhrWIkuWRFlp4VYc0TExrUP6JT0KUNp6v7HbziZ4VrTQSQ4stX2AlVu96CWyrEGDG
         xzdH4X5/5N8fMpPrTfgNMM76rWYoQcXb08cUs7EOK66mpck25gAng1LG8rBZn9d8PE/u
         4sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761031926; x=1761636726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80GPaLt8RJEs0Dy2pPxjPW4aTwa88xJPXSCXcH5OIhw=;
        b=Y15xeEDPvRL+Kr4bwsaWihAZAms703ZDn21o9QeH16A9hDIaIR96zoDiETenXu6aS7
         qxwkds1sCiR7/6hPctVSgMIV5uhz1X53s7bAkNsL+KuDJTN/9IdCW5f6Npk/VokXEJte
         SUyebEb50UBJV8Bivw7u0cp00Frb5WRMqhYnDsuA6jSDv27UCEoAWtPiDL+QsDVc3dur
         ck2bU/uD3AdrTGfjlfaIDagOhOzR/x3ksF/wAj+mnS+WQrsYlYeYH6mE54z0OE+jom4Q
         FTPDo3vwQp1950lM4Zc+GgOlRugWV29zX780Dt8YsxfLe7LLV6HDbdo4TJfwx2xMniwo
         CCPg==
X-Gm-Message-State: AOJu0Yw2aIe7S1ckuNqDvplHdSh7Gf1ygpclhQbj3ZRJvtilDC86CEPg
	ZbeMdBCniEDYZJoqqdJeMcBUODQj+qNi4uR962AOX/okij5GpflFtAWz8rZJ0pjidYaueyJcIsU
	+gl6Gl17dciH/oG/pyiuOraaV87yabLI=
X-Gm-Gg: ASbGncuzzqMejp+cZXsOfxcrNbI9OujY/tsJ2eXDmatk0KXQFiZW3GsgBi85+njL0iV
	w4CZcnaCLiJEjLSgTztenYgL75LFDkzYprmWi2/B2B39XOdQX+JMRWRcbrBud05haFmOu1bARVY
	NBv1edKuzwO+K4ZHv2zK88afk5P9zd26riw5AQT/P6Q6hwd3FXmd6pr/VMJ6xFl7fhT8GGSFjOk
	MtIkplMeLmQDew0f/2eCnPVVWkjU/pP4q7TZgU0fpCSyAlRHLYsW8szN9s/yHMR8X24NQ==
X-Google-Smtp-Source: AGHT+IEeY3YShWt8oQCpP032A+WkeipcrqXc6vIfLRMS0m9QP581SH/H95Dh3/RFp9umvNag6LF1irbP4LG4duUXxzw=
X-Received: by 2002:a05:690e:1484:b0:63e:3a34:7bb3 with SMTP id
 956f58d0204a3-63e3a34914bmr4567917d50.14.1761031926185; Tue, 21 Oct 2025
 00:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com> <aPPthnO3bKFhTN3A@ashevche-desk.local>
In-Reply-To: <aPPthnO3bKFhTN3A@ashevche-desk.local>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 21 Oct 2025 09:31:54 +0200
X-Gm-Features: AS18NWB8jumT2LroU3IjoKum0Y2-hjLmxFjf2_tNlaFYPpDTPqRv8Y1Mji-zvMk
Message-ID: <CAOiHx=npyRdxvN7EywuXTvOMPYQ2FE_T7eVVJtZzh3Di05hxJQ@mail.gmail.com>
Subject: Re: i2c-mux ACPI parent device references in example
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 18, 2025 at 9:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Oct 08, 2025 at 11:14:37AM +0200, Jonas Gorski wrote:
> > Hi,
> >
> > I'm currently trying to wrap my head around describing devices via SSDT=
.
> >
> > While reading Documentation/firmware-guide/acpi/i2c-muxes.rst, the
> > references used for the devices behind the mux confuse me a bit.
> >
> > The tree from the example is:
> >
> >     Device (SMB1)
> >     {
> >         Device (MUX0)
> >         {
> >             Device (CH00)
> >             {
> >                 Device (CLIA)
> >                 {
> >                     Name (_CRS, ResourceTemplate () {
> >                         I2cSerialBus (0x50, ControllerInitiated, I2C_SP=
EED,
> >                                     AddressingMode7Bit, "\\_SB.SMB1.CH0=
0", 0x00,
> >                                     ResourceConsumer,,)
> >                     }
> >                 }
> >             }
> >
> >             Device (CH01)
> >             {
> >                 Device (CLIB)
> >                 {
> >                     Name (_CRS, ResourceTemplate () {
> >                         I2cSerialBus (0x50, ControllerInitiated, I2C_SP=
EED,
> >                                     AddressingMode7Bit, "\\_SB.SMB1.CH0=
1", 0x00,
> >                                     ResourceConsumer,,)
> >                     }
> >                 }
> >             }
> >         }
> >     }
> >
> >
> > Is there a ".MUX0" missing in the references, or is it correct that it =
is not
> > present?
> >
> > E.g. should it be "\\_SB.SMB1.MUX0.CH00" instead of "\\_SB.SMB1.CH00"?
> >
> > FWIW, the references were changed from relative to absolute in e65cb011=
349e
> > ("Documentation: ACPI: Fix parent device references").
>
> Oh, seems to me like a miss from my side. Thanks for a good catch!
> Can you send a formal fix patch?

Was my plan until my internet connection went down yesterday. Will
send it out once it's back.

Best regards,
Jonas

