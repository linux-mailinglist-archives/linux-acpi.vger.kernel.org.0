Return-Path: <linux-acpi+bounces-19480-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A71ACAB7D0
	for <lists+linux-acpi@lfdr.de>; Sun, 07 Dec 2025 17:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3492D300B34C
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Dec 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DB6241CB6;
	Sun,  7 Dec 2025 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBir91JH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8301C84DC
	for <linux-acpi@vger.kernel.org>; Sun,  7 Dec 2025 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765125968; cv=none; b=rlGTRXIf3dpxvJrw/dne8mQ+7izVeWRrzJCIsJMy1SNnkvGQdDNbGJtNfRN2wUvbspESxxqnjoUG4u6fM1ZhhVYXDXGtz3pi20LXvG8zUvS/61uS4lWJQG6ywL91/UsscSHUfPcsdJbKWmTb0I4TAWWuemQOAB2HUVy3NisAA58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765125968; c=relaxed/simple;
	bh=I9Qx9n4Q79mBOZR4LXGGw10jVvLQ+xkac3lc1hwUVxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZUgWXcrJoPDZgqruYVJAQzhoOAvqkVXqOx/Nqq9UOwqGaWoeskAi7p3uUG5oC06crfZzLirK8SIT/BPmVmc81HBSHjSrKwaTMe1LRwe6ATmf19/NXH0dNUyBU6r2LNcyyJgmGJYbPYQMwa30NTwg79eOyxzfgIfeBxAQFwvnts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBir91JH; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78a712cfbc0so40427477b3.1
        for <linux-acpi@vger.kernel.org>; Sun, 07 Dec 2025 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765125965; x=1765730765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9Qx9n4Q79mBOZR4LXGGw10jVvLQ+xkac3lc1hwUVxg=;
        b=CBir91JHkBNAEdojL2uT5hVYkK454TrqGILqeUbBA05z9UULrwX+ue7tzZJ1LGxDRK
         sggrLWEpkJvwuFrzzFZd8y9zRg5nJnQ8d4rppNg39LauVtJ11jf5zRU+WXuKKy3xdh+y
         GnOwpOGPhPslsjYOjt5c13M5BpbGBBuEYPS3EqhV7TcPOLfZxCM2F0XtM+btDZQ0Smhy
         S0LgEhFFpAoPkiN7NE9+iyJme0H/QYPfDNx1ziv3lYNDQNMop52xI6ib/PK0VY5+Ztn0
         RnqTAiIOvSiclU4bgeAM+zOgsVchZYeKHtVqXlIXeQQT0b+7DZJ1KhjSuMl2qu7E/o8/
         +Xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765125965; x=1765730765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9Qx9n4Q79mBOZR4LXGGw10jVvLQ+xkac3lc1hwUVxg=;
        b=sTkMPxBjhvyWr/s2KE4w6NwbdCghlRgGv+cEHL9wc1+DUicL8Q+FLAYCETGCRcf0OR
         TggbLACkMqXb7T1cy6++DXsBjyZEc3ZVPi8VQPi1KxQCOu3bCvP7dJRdkXDkN+SCBhP7
         XjwN5UOCY5uSUT3H5FQHlkHZVxoEVM0iLBDik/kc5kwywyUy29nWWSVfuz+ka0h7LRPV
         nAmHRVwIZNr40ayNAs202mbR8Xv7W8O8wwxvdpv+sNwgaN7UXavpEOpvv7potohy+NQz
         ATxMSVS6LldHl0ZOcg0SzPI05f5JVBkhjxbCef+kIiyEep8exrnH2BntdoI8417848w8
         yc3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWj2zbM8YSSoYZdqWujKbTAseaktTPE49/5ITBzbVBKJ6qktTmRz6f1MscGX3UoL68T+xOYrbgsWYLo@vger.kernel.org
X-Gm-Message-State: AOJu0YxVhWAAUkaY7WcXPju9VJqrvFcMrAfiaB/ZllGqIkAMEtQH2PpV
	aJcHDxewMoFNO02VfYcxk7qoR04YvBFCf/H3fAEOY7RcdRTr4oLg3XJjKrjGsiFwr5LMqq98upW
	zUWzmlef+piq2U649qM/utSFUG20EhEA=
X-Gm-Gg: ASbGnctNXL72vYQ3uE/DjaIJE4vqWltQ9rPMNI0IqHVUfhIZdH85zN3QzVBOYWi+Y0f
	KmgnrxoE8DMJyXIG5YYtwDTvcUkCafh1DojtSX+8ng83gpRz/7rXJnyNPApLoI0wEuZOM7RlEo/
	7omXTzm15eerQBwiwnW2CL586qq/1mD6Zv6ULGOXdd73XHEdX9CE6MB0y8+nHAnn75UQKxHF4Ar
	DKN+l2alryQwVByOrvL6LJA3oZz0x7bTQD11xlf1jL8vCcBhBfUAS7slzHBXRVv9NkrK1La
X-Google-Smtp-Source: AGHT+IFojsrwzBu58xmxqNiWONYhG9kxExBjgU7MJi2fTygt5IzjBHutS+yPKMllDxNSv0iDWafdsrpjLRVd2Us7NKw=
X-Received: by 2002:a05:690c:d91:b0:788:bda:47e0 with SMTP id
 00721157ae682-78c33b13875mr51874287b3.1.1765125964673; Sun, 07 Dec 2025
 08:46:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTLjgEVfLCot0cSm@smile.fi.intel.com> <20251207040459.3581966-1-safinaskar@gmail.com>
 <aTVUakljrd-sysxP@smile.fi.intel.com>
In-Reply-To: <aTVUakljrd-sysxP@smile.fi.intel.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Sun, 7 Dec 2025 19:45:28 +0300
X-Gm-Features: AQt7F2qzPmg7UQ_bISru9-YSQqKjGJESrT0FY3SlqV8KJLp0EpCcDQigL4yk178
Message-ID: <CAPnZJGAxhXNOw1V5FTPK2Mrvu0YAPwm0Ph4UHd2aZv=kgx1qWg@mail.gmail.com>
Subject: Re: [REGRESSION][BISECTED] Dell Precision 7780 wakes up on its own
 from suspend
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dell.Client.Kernel@dell.com, bartosz.golaszewski@linaro.org, 
	benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, 
	linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, regressions@lists.linux.dev, rrangel@chromium.org, 
	superm1@kernel.org, wse@tuxedocomputers.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 1:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> I think nothing. It's better to try to actually fix the non-working scena=
rios
> rather than remove the feature completely.

OK.

> P.S.
> I'm sorry, but why are you so eager to remove something? While in many ca=
ses
> removal of (potentially dead or unused) code is considered a good thing, =
it's
> not always the case.

Removing code is easier than writing new code. :)

Speaking of initrd, I tried to understand Linux init code a long time
ago (out of curiosity),
and so I wanted to remove initrd (to help me understand the code).
Also I saw initrd
deprecation notice back in 2020, and I decided to send a patch for its
removal back then.
But I got time for this only now.

--=20
Askar Safin

