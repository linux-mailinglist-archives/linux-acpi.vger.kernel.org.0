Return-Path: <linux-acpi+bounces-20689-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIORCFIfeWkQvgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20689-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:25:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD679A58B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 21:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25419302BDC3
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 20:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C73A36EA99;
	Tue, 27 Jan 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxHewYd8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE41FDE31
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545551; cv=pass; b=bAqcyupvtQsIlqoTF5dgROWkK2fzbN2WkIJPi5QqqdXoS9gOqV6Og3LiXibN20SoOcA+R/mvlQz+SKz6W4D3ACtDqIXL3DBJULNgvaT2NahsWV+PbIb0R66z2vVOVrXN4GkXQlLYxmDpoVi66oWEmAoPFUdrKnLP92k8WTqBq+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545551; c=relaxed/simple;
	bh=3Bu3aT9H0JEhRUqtdPqdEU/W9oFeYT+vLnsqglOA+Ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK1BK1Bswvd9iHSOJXylKu0RHEvfJXZB2h+rxVtBhap6QB5kT7WVqg68ZvfOHFkhdfEAMTXcN43WylfsTBXwPJyzMHEiKXJomAF2eUAqWPo+VhbyARd7RTdGVOlESK6RR+uMtPUQOUe7tFvEF2KCbeC7NsDWNtxKttDv0LMY58k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxHewYd8; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8838339fc6so43329166b.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 12:25:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769545548; cv=none;
        d=google.com; s=arc-20240605;
        b=QTW30Ix6LdOjmXaGPmj5un8z8h5LpCclH6q+iFtXiyL4kNOzv0Du9/ilWTcTeVyyUu
         bR2mQIuXGlEtE1KVnPgMqOzQcOZHrEJB0LdY0Q75zPVwuk4iXCg11ewO5MAN2eRwCBXU
         l3W+pgK0y8RGy/CNCfAEMYuRhQRqYXi0kzsCnZ3JJMpHriYtrpoiMvYgPL+ki7GnHlHj
         5rdzLHKF35SHLrPF9T5ikwqdR4+EarLB0wTcBEYBq/0bbVA7I7XbCYtORPiOwHMsRCHK
         PFVWHQcd3jwCTJiU6WXkLsrzLbeKmj3I+13Ysqn2Gek+IIG66Q0+DRQihtoO0ZrU0kYy
         1+vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GdzToIEc1zbyhCAPVwQFbZZZhEOGRBe5POTMorpGMcc=;
        fh=U5Rmd0L0+WmcTlqaVmUzKvRbLMbwKDQ5CV1TGg10Fu0=;
        b=eIhdZy6RZV3Re3UUmPUjkxbq1o0CjBxuPIOUC2h3vOZN3O7H9un5z7m/N8Hnp5FGqQ
         IJLXGLMRpvlSYXNIWEJzobVSJuq7KPKIe8H6XRx6MvYU4iKD8COEttaOwT3TOkbqJS8S
         XNi64/oua8kN+BRWf0kzh8aa0DN8UY8GEwbd3eH7wyyWM8wThqTiTINTK07WotPHhmlb
         72hgwi7P5Zb9kEqXqfe2TkB6p/mmUf/I9Td4EE+uWTCWfL+KEKUgUVBf1gMeHaMNse/e
         rWYBe8gBVCaezEC6ClZL0BwzWYwNFiCrl+0nlMRdGGjq58z+dOkuwDtpMAyKe2cmWulK
         8DKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769545548; x=1770150348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdzToIEc1zbyhCAPVwQFbZZZhEOGRBe5POTMorpGMcc=;
        b=fxHewYd8/desyjJ6LOU8cy0J9je/JTRJXLXeTG1iCsRGzko+GvTR7CIWfKiZojkUmR
         ej1UWCzjFdnoCOO1cDqXpdpi8wFpaYISkeMSnP0vpC3wc1DVMGM406zNzWKW+J1/6e8o
         bupFwNn6eKgzb19HFrUREuijKhpybsQRFLYxDkmqNsnU1cSBdzNDoctAvJyuWTa7qP4h
         BpLVDKPAhrM74Y+pGdKDYuUdl0KPoOoPm1Egeaz2r/VPEUZbs6DtT/M1m51NVkPn8cwS
         nft5timObgVetHZUy9J0CLMMxSdFxPRGl0ns++Hks7esIGBXmv0+lffGikyOVySOCcKw
         AdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769545548; x=1770150348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GdzToIEc1zbyhCAPVwQFbZZZhEOGRBe5POTMorpGMcc=;
        b=c+1ye6dPWfWF9B1yVa31z+6gO1dtQv2JL3XMyhV9tF9pqdiyjjNhzz144jUlXqxGVq
         VI0t0Xn6VvUdUSz1aRfdN8hXmJtSh1oAaiWM9foHDhQp9Lpk1u4UMFgb3EeXLqhuFlFi
         X70S4XyWwfwObiQ0QSDr2p9BMS+H5cuRiE+64nCR8cBZOUhusBugM4ob9svJ+J9pWxPA
         NQe1LAXohOk2O9HdTYvVip9dYObSezWy+OTy5tPUp0P7jTlwHrQpl/LLfUdgcEIvjMwc
         io0NQK45xHaFJ+RtPFEhxzzu8o/EAPwbvCrNB/loEYnk8NlyGa9GVwLix6KNOpMK5HPx
         I9jA==
X-Forwarded-Encrypted: i=1; AJvYcCUu2LHTOQMyt0R3YYfUk+U1pxOz+zw5UPEB5wmyvTpoW5QC/nINqB9mi2ByH++eHvqMnWzMep6vOOIp@vger.kernel.org
X-Gm-Message-State: AOJu0Yz97mF3JKWvBxxfPYXP7OEm6p8GQjC/vvUiztBq0OvF5lEiTB5C
	s4cSvbwj61mIzJn5uuh0LQlqOXHwCtu9ARMIUe2wjDq9E4bYlbxfmiBLp3Sc8tfRdaRs5TK7dT0
	vy7239zQy3V8/3lc+tQR/tzHq1Bmd7TGzL5FSOa3OpQ==
X-Gm-Gg: AZuq6aK/URKKuwPgPNkUqAbm3W6K1urFc3F/Ctircm6QCdsq23Bp+ZgfrDxsvgDsg9C
	1B66D1rTadEh+LoPqoNOJ6y4UR9xzAECaMkgNTeLrKlA5CR4mSdjY9caLCqvfHv1TuXvoCdjPzv
	t4mXkDiJu8RYTj2zvcXIQzSaw6KOt6rfssjHX764/LMbe84eF/v1Uw4cIewaK1eUYFMdR4ap8k3
	+ENGzJgXk9worXXwQvDh/Z2xQywMxG7x5044IYkF0lxo/4Nm+T7kUzxwEUecZQ8fjYO5mWn
X-Received: by 2002:a17:907:961f:b0:b88:3877:d922 with SMTP id
 a640c23a62f3a-b8dac9ea3f9mr225874566b.10.1769545547891; Tue, 27 Jan 2026
 12:25:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107154015.322698-1-jriemenschne@student.ethz.ch>
 <CAJZ5v0gj6YmypO7B-FpjPKc3WK3R5HSso0RaMBER9FMripYCaA@mail.gmail.com>
 <CAGwozwF_Phm_MiLg3Zv89aZUGgV-DW6crXT5P9n75hd7j7hQjw@mail.gmail.com> <CAK19rJ=CWRwzOi_dmaOTtcj+KFtdigZVNE93Nkr-H9veazDbQg@mail.gmail.com>
In-Reply-To: <CAK19rJ=CWRwzOi_dmaOTtcj+KFtdigZVNE93Nkr-H9veazDbQg@mail.gmail.com>
From: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
Date: Tue, 27 Jan 2026 21:25:50 +0100
X-Gm-Features: AZwV_Qgq2oTppwWA6J5sjiIW2qbXGrS5SnAJyOvNA1g_xtCmj1PdH02EvhMhuLM
Message-ID: <CAK19rJmVhRnGF_jCgCzgVbwYBPLLxvvreiOoE-NmXrzOAUiUkQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9 (Turn
 On Display)
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20689-lists,linux-acpi=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riemenschneiderjakob@gmail.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,antheas.dev:email]
X-Rspamd-Queue-Id: 6CD679A58B
X-Rspamd-Action: no action

Thank you both for the review and feedback.

@Rafael: To answer your question regarding real world examples, I have
updated the
commit message to include details about the Lenovo Yoga Slim 7i Aura (15ILL=
9).
On this device, the EC fails to wake the fans and keyboard
backlight without this specific Function 9 notification.

@Antheas: Thank you for the explanation regarding the ordering.
I have updated the patch to follow your suggested sequence
to ensure the firmware receives the intent signal before the software
sleep exit.
I have also renamed the constant to ACPI_MS_TURN_ON_DISPLAY as requested.

I have just sent a v2 patch incorporating these changes.

Best regards,
Jakob


On Tue, Jan 27, 2026 at 9:06=E2=80=AFPM Jakob Riemenschneider
<riemenschneiderjakob@gmail.com> wrote:
>
> Thank you both for the review and feedback.
>
> @Rafael: To answer your question regarding field observations, I have upd=
ated the
> commit message to include details about the Lenovo Yoga Slim 7i Aura (15I=
LL9).
> On this device, the EC fails to wake the fans and keyboard
> backlight without this specific Function 9 notification.
>
> @Antheas: Thank you for the explanation regarding the ordering.
> I have updated the patch to follow your suggested sequence
> to ensure the firmware receives the intent signal before the software sle=
ep exit.
> I have also renamed the constant to ACPI_MS_TURN_ON_DISPLAY as requested.
>
> I have just sent a v2 patch incorporating these changes.
>
> Best regards,
> Jakob
>
>
>
> On Tue, Jan 27, 2026 at 4:59=E2=80=AFPM Antheas Kapenekakis <lkml@antheas=
.dev> wrote:
>>
>> On Tue, 27 Jan 2026 at 15:50, Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>> >
>> > On Wed, Jan 7, 2026 at 4:40=E2=80=AFPM Jakob Riemenschneider
>> > <riemenschneiderjakob@gmail.com> wrote:
>> > >
>> > > Windows 11, version 22H2 introduced a new function index (Function 9=
) to
>> > > the Microsoft LPS0 _DSM, titled "Turn On Display Notification".
>> > >
>> > > According to Microsoft documentation, this function signals to the s=
ystem
>> > > firmware that the OS intends to turn on the display when exiting Mod=
ern
>> > > Standby. This allows the firmware to release Power Limits (PLx) earl=
ier,
>> > > improving resume latency on supported OEM designs. Without this call=
,
>> > > some devices may remain in a throttled power state longer than neces=
sary
>> > > during resume.
>> >
>> > Has this been observed in the field?
>> >
>> > Any examples?
>> >
>> > > This patch defines the new function index (ACPI_LPS0_MS_DISPLAY_ON) =
and
>> > > invokes it in acpi_s2idle_restore_early_lps0() immediately after the
>> > > screen-on notification, provided the firmware supports the function =
in
>> > > its mask.
>> > >
>> > > Link: https://learn.microsoft.com/en-us/windows-hardware/design/devi=
ce-experiences/modern-standby-firmware-notifications#turn-on-display-notifi=
cation-function-9
>> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D220505
>> > > Signed-off-by: Jakob Riemenschneider <jriemenschne@student.ethz.ch>
>> > > ---
>> > >  drivers/acpi/x86/s2idle.c | 10 +++++++++-
>> > >  1 file changed, 9 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
>> > > index 6d4d06236..4ce4cc8a0 100644
>> > > --- a/drivers/acpi/x86/s2idle.c
>> > > +++ b/drivers/acpi/x86/s2idle.c
>> > > @@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids=
[] =3D {
>> > >  #define ACPI_LPS0_EXIT         6
>> > >  #define ACPI_LPS0_MS_ENTRY      7
>> > >  #define ACPI_LPS0_MS_EXIT       8
>> > > +#define ACPI_LPS0_MS_DISPLAY_ON 9
>> > >
>> > >  /* AMD */
>> > >  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122=
d37721"
>> > > @@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(u=
nsigned int state)
>> > >                         return "lps0 ms entry";
>> > >                 case ACPI_LPS0_MS_EXIT:
>> > >                         return "lps0 ms exit";
>> > > +               case ACPI_LPS0_MS_DISPLAY_ON:
>> > > +                       return "lps0 ms display on";
>> > >                 }
>> > >         } else {
>> > >                 switch (state) {
>> > > @@ -618,9 +621,14 @@ static void acpi_s2idle_restore_early_lps0(void=
)
>> > >         }
>> > >
>> > >         /* Screen on */
>> > > -       if (lps0_dsm_func_mask_microsoft > 0)
>> > > +       if (lps0_dsm_func_mask_microsoft > 0) {
>> > >                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
>> > >                                 lps0_dsm_func_mask_microsoft, lps0_d=
sm_guid_microsoft);
>> > > +                               /* Modern Turn Display On */
>> > > +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_DISPLAY_ON,
>> > > +                               lps0_dsm_func_mask_microsoft, lps0_d=
sm_guid_microsoft);
>> >
>> > Is the ordering right with respect to the non-MSFT screen-on
>> > notifications below?
>> >
>> > I would expect it to be done after all of the screen-on notifications,
>> > so is there a specific reason to do it earlier?
>> >
>> > > +       }
>> > > +
>> > >         if (lps0_dsm_func_mask > 0)
>> > >                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
>> > >                                         ACPI_LPS0_SCREEN_ON_AMD :
>> > > --
>> >
>> > Also, this kind of clashes with the "dark mode" work in progress, see
>> > for example:
>> >
>> > https://lore.kernel.org/linux-acpi/20251226102656.6296-1-lkml@antheas.=
dev/
>> >
>>
>> Hi,
>> I wasn't aware of a device that uses this function but I guess OEMs
>> could so they shipped buggy firmware. It is added speculatively in my
>> series.
>>
>> Technically, it is supposed to be called before ms exit, as windows
>> uses it to signal that _it will_ turn on the display while in sleep.
>> So, exit, intent, ms exit, display on.
>>
>> I am not sure if it is also called when in the "screen off" state if
>> the device uses the mouse while inactive. Someone would need to check
>> in Windows using power manager. I do not have a device to check.
>>
>> So, two comments from me:
>>   - Move to before ms_exit, or show it should be fired after (sleep
>> exit in windows)
>>   - Change the name, as it is a bit confusing, perhaps to
>> ACPI_MS_TURN_ON_DISPLAY or similar. If you can make that change I will
>> ack it and add rby
>>
>> This merging first simplifies my series so it should go through (I can
>> drop "[RFC v1 6/8] acpi/x86: s2idle: implement turn on display DSM as
>> resume notification").
>>
>> In addition, as we now know resume needs to fire always, I will need
>> to make some changes for V2 of my series to make sure that happens
>>
>> Antheas
>>

