Return-Path: <linux-acpi+bounces-6169-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AF8FB1CE
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 14:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E833E28244C
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jun 2024 12:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C16145B12;
	Tue,  4 Jun 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNBanyZ6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA0713D609;
	Tue,  4 Jun 2024 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502856; cv=none; b=RKkXmK1T/GSpmdfc/GUQdopR+3lMm8fOq00s5OzpGJTnwBpzLmU1o40BjiegDWkK8Y8DcoB0PBd12mzrfOFZMavs5KA8R7QIwdx24A2E5omx/aUdDPiCPrxNQeKw8hwzD0Du74YVv6BkQOcEaLy/r5DdJxQvDtLyOcRDKc/kdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502856; c=relaxed/simple;
	bh=HMDbYgqTJpPgikhVUtIdqxkkkujpvvcYvcdFP5Poxaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDNYl3CH9SFijd2tAYIECasJMBDRRtLJVdq3FdG8X7yaCFT+6f6rMhc1rXQTPVw+3xOSS3YyrnlhqZ4JpyP34ASye//9F16PYO5uWo0pUY1PC+iqsyAijaSWJFSXdPrvkujVqgBj9dGFu9QtXmSErpDKzVK+Z1H0MmNaU7QgFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNBanyZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED72C4AF08;
	Tue,  4 Jun 2024 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717502855;
	bh=HMDbYgqTJpPgikhVUtIdqxkkkujpvvcYvcdFP5Poxaw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hNBanyZ6sNoUtD3u+Z1BunrFq0Xw7ZTQEjPrew4Ou4Ir53ZcL2/Xgj7c59qCndAAv
	 fpb3aJGHGpixHJnet7F0x2zLj+EgaqoVctHAlIYmDo8XboeFgiUrAZCuMwYSYkTUV9
	 eYUEFvjwX5w0mUnBpd53UEdvBSr1vsTBdXLnVAw3LxIHE2XwLGM8nRbfeiJl2rNxLb
	 8XFRG7cic9jDHng1ohYisost4YxydaxMhTHGepiayMNpZR38WZp0JPimi4O9A+jWvN
	 GimMLrZd2mnyb4IagtEmSqHiCtfkWyf7BwaPbCFSf8JSNAdDwfg7mFbvKM+B16Ylte
	 fOfZbh2DqjBVQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ba65db2d05so13597eaf.0;
        Tue, 04 Jun 2024 05:07:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUe56SgzabKqjwRsfg7pKwN63qcXLTGmKQ6qSEUTfLccnrRsUV8qFgDZ1fE4uhKHiJ+oF8hM2vZ/u12tkMth/DETull3smRBtURzctsFo72W3MCup8OxtSjOkVFacsP2B6KCWqqqyf93g==
X-Gm-Message-State: AOJu0Yxbxad+wTnWAX/J+RoHV6SVaDWALtrhmFyGPTrd7jxDt4Iu2xM7
	Tudj4+bpGUzNSkBQ/vazmGDSfC/rkFO/lyEfSErEWuhmb3Eetzm7qUfdZNzZDbLPaZriFCQacZp
	PwA4WcI2UqjK5dnPRJvGpa/z0uvw=
X-Google-Smtp-Source: AGHT+IEo+TPQjBW+A+ida4mSSBEw/RE4nus43DBmRDn0u/N/LIsXMRyCqH3KGBye7lGKAezAvrB7Zs+qb9dKrtks9W8=
X-Received: by 2002:a05:6820:b43:b0:5ba:6959:edf8 with SMTP id
 006d021491bc7-5ba6959efe4mr1135214eaf.1.1717502854963; Tue, 04 Jun 2024
 05:07:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530153727.843378-1-laura.nao@collabora.com>
 <20240531113534.577055-1-laura.nao@collabora.com> <CAJZ5v0i2g70Bpu5iyUpsspNrHZ67eR82y8iqq+EjWSkpBhmkUg@mail.gmail.com>
In-Reply-To: <CAJZ5v0i2g70Bpu5iyUpsspNrHZ67eR82y8iqq+EjWSkpBhmkUg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 4 Jun 2024 14:07:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jP4TKojEMcMutptYFC=o0zJLyHfCBVOdcwp4tzSNK_4A@mail.gmail.com>
Message-ID: <CAJZ5v0jP4TKojEMcMutptYFC=o0zJLyHfCBVOdcwp4tzSNK_4A@mail.gmail.com>
Subject: Re: [REGRESSION] probe with driver acpi-fan failed with error -22
To: Laura Nao <laura.nao@collabora.com>
Cc: kernel@collabora.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="00000000000092f01b061a0f4bed"

--00000000000092f01b061a0f4bed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 8:20=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi,
>
> On Fri, May 31, 2024 at 1:35=E2=80=AFPM Laura Nao <laura.nao@collabora.co=
m> wrote:
> >
> > Hello,
> >
> > On 5/30/24 17:37, Laura Nao wrote:
> > > Hello,
> > >
> > > We have identified a regression in the acpi-fan driver probe between
> > > v6.9-rc7 and v6.10-rc1 on some Intel Chromebooks in the Collabora LAV=
A
> > > lab.
> > >
> > > For the Acer Chromebook Spin 514 (CP514-2H), the following error is
> > > reported in the logs:
> > >
> > > [    0.651202] acpi-fan INTC1044:00: probe with driver acpi-fan faile=
d with error -22
> > >
> > > Similar errors are reported on other devices with fans compatible wit=
h
> > > the same driver.
> > >
> > > On Acer Chromebox CXI4, ASUS Chromebook Flip C436FA and
> > > HP Chromebook x360 14 G1:
> > >
> > > [    0.488001] acpi-fan INT3404:00: probe with driver acpi-fan failed=
 with error -22
> > >
> > > On ASUS Chromebook Vero 514 CBV514-1H:
> > >
> > > [    1.168905] acpi-fan INTC1048:00: probe with driver acpi-fan faile=
d with error -22
> > >
> > > The issue is still present on next-20240529.
> > >
> > > I'm sending this report to track the regression while a fix is
> > > identified. I'll investigate the issue/run a bisection and report bac=
k
> > > with the results.
> > >
> > > This regression was discovered during some preliminary tests with the
> > > ACPI probe kselftest [1] in KernelCI. The config used was the upstrea=
m
> > > x86_64 defconfig with a fragment applied on top [2].
> > >
> > > Best,
> > >
> > > Laura
> > >
> > > [1] https://lore.kernel.org/all/20240308144933.337107-1-laura.nao@col=
labora.com/
> > > [2] https://pastebin.com/raw/0tFM0Zyg
> > >
> > > #regzbot introduced: v6.9-rc7..v6.10-rc1
> >
> > The issue started happening after:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/thermal/thermal_core.c?h=3Dv6.10-rc1&id=3D31a0fa0019b022024cc082=
ae292951a596b06f8c
> >
> > Before this commit, get_cur_state() was not called by
> > __thermal_cooling_device_register, so the error was not triggered.
> >
> > After enabling debugging for the acpi-fan driver, I noticed these error=
s
> > in the logs:
> >
> > [    0.682224] acpi INTC1044:00: Invalid control value returned
> > [    0.682635] acpi INTC1044:00: Invalid control value returned
> >
> > The value stored in fst.control is 255, which is indeed not a valid
> > value.
> >
> > I suspect this might be a firmware issue that is now manifesting due to
> > the addition of the extra get_cur_state() call.
> >
> > I'll dig a bit more and report back.
>
> It looks like _FST returns all ones if it is evaluated before _FSL on
> the affected platforms.
>
> It shouldn't do that, but then it is not particularly useful to fail
> cdev registration for this reason.
>
> The attached patch should work around this issue, please try it and repor=
t back.

A !ret check is missing in that patch, so please try the attached new
version of it instead.

Thanks!

--00000000000092f01b061a0f4bed
Content-Type: application/x-patch; name="thermal-cdev-init-2.patch"
Content-Disposition: attachment; filename="thermal-cdev-init-2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lx0csvlc0>
X-Attachment-Id: f_lx0csvlc0

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
cmV0ID0gY2Rldi0+b3BzLT5nZXRfY3VyX3N0YXRlKGNkZXYsICZ2YWwpOworCWlmICghcmV0ICYm
IHZhbCA+PSAwICYmIHZhbCA8PSBJTlRfTUFYKQorCQljdXJyZW50X3N0YXRlID0gdmFsOworCWVs
c2UKKwkJY3VycmVudF9zdGF0ZSA9IC0xOwogCiAJdGhlcm1hbF9jb29saW5nX2RldmljZV9zZXR1
cF9zeXNmcyhjZGV2KTsKIApJbmRleDogbGludXgtcG0vZHJpdmVycy90aGVybWFsL3RoZXJtYWxf
ZGVidWdmcy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KLS0tIGxpbnV4LXBtLm9yaWcvZHJpdmVycy90aGVybWFsL3Ro
ZXJtYWxfZGVidWdmcy5jCisrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9kZWJ1
Z2ZzLmMKQEAgLTQyMSw2ICs0MjEsOCBAQCB2b2lkIHRoZXJtYWxfZGVidWdfY2Rldl9zdGF0ZV91
cGRhdGUoY29uCiAJY2Rldl9kYmcgPSAmdGhlcm1hbF9kYmctPmNkZXZfZGJnOwogCiAJb2xkX3N0
YXRlID0gY2Rldl9kYmctPmN1cnJlbnRfc3RhdGU7CisJaWYgKG9sZF9zdGF0ZSA8IDApCisJCWdv
dG8gdW5sb2NrOwogCiAJLyoKIAkgKiBHZXQgdGhlIG9sZCBzdGF0ZSBpbmZvcm1hdGlvbiBpbiB0
aGUgZHVyYXRpb25zIGxpc3QuIElmCkBAIC00NjMsNiArNDY1LDcgQEAgdm9pZCB0aGVybWFsX2Rl
YnVnX2NkZXZfc3RhdGVfdXBkYXRlKGNvbgogCiAJY2Rldl9kYmctPnRvdGFsKys7CiAKK3VubG9j
azoKIAltdXRleF91bmxvY2soJnRoZXJtYWxfZGJnLT5sb2NrKTsKIH0KIApAQCAtNDk5LDcgKzUw
Miw5IEBAIHZvaWQgdGhlcm1hbF9kZWJ1Z19jZGV2X2FkZChzdHJ1Y3QgdGhlcm0KIAkgKiBkdXJh
dGlvbiB3aWxsIGJlIHByaW50ZWQgYnkgY2Rldl9kdF9zZXFfc2hvdygpIGFzIGV4cGVjdGVkIGlm
IGl0CiAJICogcnVucyBiZWZvcmUgdGhlIGZpcnN0IHN0YXRlIHRyYW5zaXRpb24uCiAJICovCi0J
dGhlcm1hbF9kZWJ1Z2ZzX2NkZXZfcmVjb3JkX2dldCh0aGVybWFsX2RiZywgY2Rldl9kYmctPmR1
cmF0aW9ucywgc3RhdGUpOworCWlmIChzdGF0ZSA+PSAwKQorCQl0aGVybWFsX2RlYnVnZnNfY2Rl
dl9yZWNvcmRfZ2V0KHRoZXJtYWxfZGJnLCBjZGV2X2RiZy0+ZHVyYXRpb25zLAorCQkJCQkJc3Rh
dGUpOwogCiAJZGVidWdmc19jcmVhdGVfZmlsZSgidHJhbnNfdGFibGUiLCAwNDAwLCB0aGVybWFs
X2RiZy0+ZF90b3AsCiAJCQkgICAgdGhlcm1hbF9kYmcsICZ0dF9mb3BzKTsK
--00000000000092f01b061a0f4bed--

