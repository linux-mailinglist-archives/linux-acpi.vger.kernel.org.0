Return-Path: <linux-acpi+bounces-6143-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95868D8881
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 20:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 143D5285D33
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 18:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068B0137C4A;
	Mon,  3 Jun 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDIXIgjh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA88137C3C;
	Mon,  3 Jun 2024 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717438822; cv=none; b=A+uINyTlmt4UxziqatnpmmfGKaO3p0dhv0Q7etO4z8DgGvYCf5xqTSJleQH7mZi2pvk8pTkMkf1YRFDQt8Qkny6OkdRESKGOaUBNb4YSwd10j73TgkgN88hNwQSTRBJvErl+F0VpiosdynxCjVvImL04Xanj2sYixffhmjyLXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717438822; c=relaxed/simple;
	bh=u5p2ERLEdtn1dk+Iu+J2FcYDM1oNuuTTvuevbuQjkME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYmoGKMUAePeGisZaDRBJDlA3NcnfvroJ3+AIGQi7SfvNTp1jdF9mt64QosDFccDq3mCueJhAEX7yxu2Uy5tpKaJ9Ila0jTwCjP0AlMOcEaTogx1ailuygNi/HEXYfoIVz8EZNw9NFoTXHrTywuAMe2Fpd2ZHb5CfY8+Jx4smMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XDIXIgjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69618C4AF08;
	Mon,  3 Jun 2024 18:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717438822;
	bh=u5p2ERLEdtn1dk+Iu+J2FcYDM1oNuuTTvuevbuQjkME=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XDIXIgjhzo4DwaJtltdipJapIMsNSwgv9puEH9tlzSihDDtJgwitdQjQAKfLOlW6a
	 SwbrvBcVk6TdP8feMuy0VXPOKvpJAxGzZmqxaLNaTTVUCrIVn11rUKrEpCcfYGo+Wg
	 Wke69cc8FswSmpcjcNrj3QpQ/6lZFTnHBd8/tViqZNpbytXkZpgOEmr8LiprWoLo7D
	 Aw+B8kzDO8/cxxr1/WCVyjscl5bVpyRvcpEdPDYd4bf9jMWAjW2c10Xnzflj+c1T1x
	 iqOF+bxVl2yCYIteOQ1dRRuKlSGVC6zZTuWoJYz8/QL8rW3zLtMUK1msynSDXECQPK
	 BTX8U2fHOW+Bw==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d1b6b6b2c5so572150b6e.0;
        Mon, 03 Jun 2024 11:20:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPWQaUcuFR6I3vXE3oXUFNZJKRMuOnzBuAGP515Fu63Zo3RLO0kTuGNhbu8r9HPshno0ITksn51uwcor8fo4mvyBScEf2AuXpW/XHEPQkdeD1uLE2L6z9wfWT5zOtUHHWPXTNY3DyUZQ==
X-Gm-Message-State: AOJu0YyPS0XE14QsgrlB8HnhQ3tw0BxWDuC5QyaDcqTJhyaD3/xeao2Z
	VhMNQEiBCiiI9L4IFtj5Ccf7dgnbR/XeK+t/G1wCrNHNEcEMUazGaMX8FmP6lsrumsmsPJp+J3w
	31Lm9irqK1lxV8C5oEIqRDdRUP9A=
X-Google-Smtp-Source: AGHT+IHaIbAV42temXdBBvINcBmmisdYaVtIMxd2bPyABEy/2wD8hQNDWhvtMFK8gle7ffFOAY0ahY9RKAHclYdDHVU=
X-Received: by 2002:a05:6870:36d5:b0:250:7a11:1ef6 with SMTP id
 586e51a60fabf-2508bdecdafmr11235936fac.4.1717438821629; Mon, 03 Jun 2024
 11:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530153727.843378-1-laura.nao@collabora.com> <20240531113534.577055-1-laura.nao@collabora.com>
In-Reply-To: <20240531113534.577055-1-laura.nao@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Jun 2024 20:20:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2g70Bpu5iyUpsspNrHZ67eR82y8iqq+EjWSkpBhmkUg@mail.gmail.com>
Message-ID: <CAJZ5v0i2g70Bpu5iyUpsspNrHZ67eR82y8iqq+EjWSkpBhmkUg@mail.gmail.com>
Subject: Re: [REGRESSION] probe with driver acpi-fan failed with error -22
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000e387b6061a006270"

--000000000000e387b6061a006270
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 31, 2024 at 1:35=E2=80=AFPM Laura Nao <laura.nao@collabora.com>=
 wrote:
>
> Hello,
>
> On 5/30/24 17:37, Laura Nao wrote:
> > Hello,
> >
> > We have identified a regression in the acpi-fan driver probe between
> > v6.9-rc7 and v6.10-rc1 on some Intel Chromebooks in the Collabora LAVA
> > lab.
> >
> > For the Acer Chromebook Spin 514 (CP514-2H), the following error is
> > reported in the logs:
> >
> > [    0.651202] acpi-fan INTC1044:00: probe with driver acpi-fan failed =
with error -22
> >
> > Similar errors are reported on other devices with fans compatible with
> > the same driver.
> >
> > On Acer Chromebox CXI4, ASUS Chromebook Flip C436FA and
> > HP Chromebook x360 14 G1:
> >
> > [    0.488001] acpi-fan INT3404:00: probe with driver acpi-fan failed w=
ith error -22
> >
> > On ASUS Chromebook Vero 514 CBV514-1H:
> >
> > [    1.168905] acpi-fan INTC1048:00: probe with driver acpi-fan failed =
with error -22
> >
> > The issue is still present on next-20240529.
> >
> > I'm sending this report to track the regression while a fix is
> > identified. I'll investigate the issue/run a bisection and report back
> > with the results.
> >
> > This regression was discovered during some preliminary tests with the
> > ACPI probe kselftest [1] in KernelCI. The config used was the upstream
> > x86_64 defconfig with a fragment applied on top [2].
> >
> > Best,
> >
> > Laura
> >
> > [1] https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@colla=
bora.com/
> > [2] https://pastebin.com/raw/0tFM0Zyg
> >
> > #regzbot introduced: v6.9-rc7..v6.10-rc1
>
> The issue started happening after:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/thermal/thermal_core.c?h=3Dv6.10-rc1&id=3D31a0fa0019b022024cc082ae=
292951a596b06f8c
>
> Before this commit, get_cur_state() was not called by
> __thermal_cooling_device_register, so the error was not triggered.
>
> After enabling debugging for the acpi-fan driver, I noticed these errors
> in the logs:
>
> [    0.682224] acpi INTC1044:00: Invalid control value returned
> [    0.682635] acpi INTC1044:00: Invalid control value returned
>
> The value stored in fst.control is 255, which is indeed not a valid
> value.
>
> I suspect this might be a firmware issue that is now manifesting due to
> the addition of the extra get_cur_state() call.
>
> I'll dig a bit more and report back.

It looks like _FST returns all ones if it is evaluated before _FSL on
the affected platforms.

It shouldn't do that, but then it is not particularly useful to fail
cdev registration for this reason.

The attached patch should work around this issue, please try it and report =
back.

--000000000000e387b6061a006270
Content-Type: text/x-patch; charset="US-ASCII"; name="thermal-cdev-init.patch"
Content-Disposition: attachment; filename="thermal-cdev-init.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lwzaoq0u0>
X-Attachment-Id: f_lwzaoq0u0

LS0tCiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMgICAgfCAgIDExICsrKysrKystLS0t
CiBkcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9kZWJ1Z2ZzLmMgfCAgICA3ICsrKysrKy0KIDIgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCkluZGV4OiBsaW51
eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgt
cG0ub3JpZy9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMKKysrIGxpbnV4LXBtL2RyaXZl
cnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYwpAQCAtOTY0LDcgKzk2NCw4IEBAIF9fdGhlcm1hbF9j
b29saW5nX2RldmljZV9yZWdpc3RlcihzdHJ1Y3QKIHsKIAlzdHJ1Y3QgdGhlcm1hbF9jb29saW5n
X2RldmljZSAqY2RldjsKIAlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqcG9zID0gTlVMTDsK
LQl1bnNpZ25lZCBsb25nIGN1cnJlbnRfc3RhdGU7CisJdW5zaWduZWQgbG9uZyB2YWw7CisJaW50
IGN1cnJlbnRfc3RhdGU7CiAJaW50IGlkLCByZXQ7CiAKIAlpZiAoIW9wcyB8fCAhb3BzLT5nZXRf
bWF4X3N0YXRlIHx8ICFvcHMtPmdldF9jdXJfc3RhdGUgfHwKQEAgLTEwMDIsOSArMTAwMywxMSBA
QCBfX3RoZXJtYWxfY29vbGluZ19kZXZpY2VfcmVnaXN0ZXIoc3RydWN0CiAJaWYgKHJldCkKIAkJ
Z290byBvdXRfY2Rldl90eXBlOwogCi0JcmV0ID0gY2Rldi0+b3BzLT5nZXRfY3VyX3N0YXRlKGNk
ZXYsICZjdXJyZW50X3N0YXRlKTsKLQlpZiAocmV0KQotCQlnb3RvIG91dF9jZGV2X3R5cGU7CisJ
cmV0ID0gY2Rldi0+b3BzLT5nZXRfY3VyX3N0YXRlKGNkZXYsICZ2YWwpOworCWlmICh2YWwgPj0g
MCAmJiB2YWwgPD0gSU5UX01BWCkKKwkJY3VycmVudF9zdGF0ZSA9IHZhbDsKKwllbHNlCisJCWN1
cnJlbnRfc3RhdGUgPSAtMTsKIAogCXRoZXJtYWxfY29vbGluZ19kZXZpY2Vfc2V0dXBfc3lzZnMo
Y2Rldik7CiAKSW5kZXg6IGxpbnV4LXBtL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2RlYnVnZnMu
Ywo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2Rl
YnVnZnMuYworKysgbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxfZGVidWdmcy5jCkBA
IC00MjEsNiArNDIxLDggQEAgdm9pZCB0aGVybWFsX2RlYnVnX2NkZXZfc3RhdGVfdXBkYXRlKGNv
bgogCWNkZXZfZGJnID0gJnRoZXJtYWxfZGJnLT5jZGV2X2RiZzsKIAogCW9sZF9zdGF0ZSA9IGNk
ZXZfZGJnLT5jdXJyZW50X3N0YXRlOworCWlmIChvbGRfc3RhdGUgPCAwKQorCQlnb3RvIHVubG9j
azsKIAogCS8qCiAJICogR2V0IHRoZSBvbGQgc3RhdGUgaW5mb3JtYXRpb24gaW4gdGhlIGR1cmF0
aW9ucyBsaXN0LiBJZgpAQCAtNDYzLDYgKzQ2NSw3IEBAIHZvaWQgdGhlcm1hbF9kZWJ1Z19jZGV2
X3N0YXRlX3VwZGF0ZShjb24KIAogCWNkZXZfZGJnLT50b3RhbCsrOwogCit1bmxvY2s6CiAJbXV0
ZXhfdW5sb2NrKCZ0aGVybWFsX2RiZy0+bG9jayk7CiB9CiAKQEAgLTQ5OSw3ICs1MDIsOSBAQCB2
b2lkIHRoZXJtYWxfZGVidWdfY2Rldl9hZGQoc3RydWN0IHRoZXJtCiAJICogZHVyYXRpb24gd2ls
bCBiZSBwcmludGVkIGJ5IGNkZXZfZHRfc2VxX3Nob3coKSBhcyBleHBlY3RlZCBpZiBpdAogCSAq
IHJ1bnMgYmVmb3JlIHRoZSBmaXJzdCBzdGF0ZSB0cmFuc2l0aW9uLgogCSAqLwotCXRoZXJtYWxf
ZGVidWdmc19jZGV2X3JlY29yZF9nZXQodGhlcm1hbF9kYmcsIGNkZXZfZGJnLT5kdXJhdGlvbnMs
IHN0YXRlKTsKKwlpZiAoc3RhdGUgPj0gMCkKKwkJdGhlcm1hbF9kZWJ1Z2ZzX2NkZXZfcmVjb3Jk
X2dldCh0aGVybWFsX2RiZywgY2Rldl9kYmctPmR1cmF0aW9ucywKKwkJCQkJCXN0YXRlKTsKIAog
CWRlYnVnZnNfY3JlYXRlX2ZpbGUoInRyYW5zX3RhYmxlIiwgMDQwMCwgdGhlcm1hbF9kYmctPmRf
dG9wLAogCQkJICAgIHRoZXJtYWxfZGJnLCAmdHRfZm9wcyk7Cg==
--000000000000e387b6061a006270--

