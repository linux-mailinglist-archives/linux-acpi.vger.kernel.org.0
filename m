Return-Path: <linux-acpi+bounces-20854-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF5yKP+jg2ldrQMAu9opvQ
	(envelope-from <linux-acpi+bounces-20854-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 20:54:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16540EC472
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Feb 2026 20:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64876300BBB2
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Feb 2026 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A485638BF7C;
	Wed,  4 Feb 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="dDo1cEAF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E2E2868B2
	for <linux-acpi@vger.kernel.org>; Wed,  4 Feb 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234875; cv=pass; b=Uix3jgk8S/Vv8C/XLmscrYIV5pCoU76l1tLPyas+f7PutcbtbvaVV8r9AoKXu0qSZ0IovmtmYceFIWV+8DU5orGtXW3t0u00g8BF9J54mifogvahpN+ZucFmOrH597JVQU0atMg8OFZzLuFb/PWy0niPJi6ULxTVpSSYMlZ8yRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234875; c=relaxed/simple;
	bh=YH0HJLb5373Z/RivYUKDeNAicXZqjKyr1an/Y13gPs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnOy4YtiNUpOBQvuY2uOGhv6+GqkJDNKAPQnIQa5HhPO7Wku//P9sjWHTUBcCHYfvhF1Zx8aX6A6lPB676WQ7rFJhK1XC6/Pus2Ckn8ghMFDwpzApjwM8WTsEtQ2EfVMbde0SHOhoIscjGQrMhjPOZeoeyjYpafCOIwNUYZSKiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=dDo1cEAF; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso309899e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 04 Feb 2026 11:54:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234873; cv=none;
        d=google.com; s=arc-20240605;
        b=KpuqHn3HaO2pFJ0ZTYefXysCTQ9sxEcTqTkLrY0ya7aOZft+fXBR7HJReivJUCNDvw
         SBsZ4PfmHDakF/mmfTe8/aFye+c7qIdcU8VT2t6C3jixXgsBgXsQ/B+Gc/CzBhinyrq9
         qpajOKSk0KkfB+Yj5sp/1UwpVCfCU1FBI+m2TzDQ1sbRLTDtDsrsEbRS0tC8HGaprwyU
         FnEHTCU2U2lLOtz+ZjB/C9Dkp0zw5N8zEBvnrg8LgaQ83yZVmzZSydrZOrouD+6OzIrt
         2UyXsjhHbukqX1JlzREUA0ramgaeEgew0M9Vdge5xOt+RMdfTAnlXDVET2dIHWd5e5ef
         vbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PsM4Q0eVZ3No3S1Lm35BrfL9EwjXAwlNKmPcOwbfzhg=;
        fh=OWaRUVPtgWBNeXPiiHR6lQFsxv4EtBZwxz7JktGcZJ0=;
        b=ciL7DPjUqvSyKYOK7yniYThQ1Wx7iibfpdzSWhpMxo3ZKV8ne0eK6K2qfC6kIhGTJ0
         Jye5xpOrc9pPiW9i3B12JA8/zvwtVslFMKXE0Ml2BUhq6cL35Nko/xJesIof2H+VFQel
         3eaacunhC7f7dhhUiR7s4r54CEMuTFLDqNUii8LJhpydFdyj8DJy+opeJSFfCK5lWSVP
         iX/ahxUMrquNkQtyMl2843xmj44SJPer6TeV8UILmCVvNweu5/ZTLh4K5UKxcDGjRNbd
         07Aifrr6irBFv2qANhW1gDr7obiftzfX3xZmt/F4J7tvHarhqy/bO1leJZ44FHrd8GaS
         UMOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1770234873; x=1770839673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PsM4Q0eVZ3No3S1Lm35BrfL9EwjXAwlNKmPcOwbfzhg=;
        b=dDo1cEAFBN6kMZzG+yBrD5wwAbObzrlWPaNm0nW3Tjloyu+rP+6XGV/bS/182EDyZO
         fEQdJDu1huW9aMNs1k6Ai1VUqE0iGDmNuVMT5ZuCDAVysJ3/jq/s6MSqlRkzOJmSIAjn
         tQZL4y8e/54v2b5BpU/pP64fUOgOHV2rbNz9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234873; x=1770839673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsM4Q0eVZ3No3S1Lm35BrfL9EwjXAwlNKmPcOwbfzhg=;
        b=qC4Y678UyYCUlct+q7EbMgdmosWTINKxn3TTjf09h4f9pK8dOeDjG4/tjHgF4VQtbB
         7G21jTTR7WtnNTzNV6QsBtkzQMWFNUToqvSeo1IrzKo2Ffmiz2J1DV8R3FEHDrgsydBs
         YM/3TSwpwiWGuwB6pM28dwRV2Ki4SS4vgODj3BTqqcfOpdAvpIAkwIFoTg8sHwDQca4L
         SCPMOW/TbnRvPxlsqLjcFe4J5kRm0UjPb7TxJAHBZMuBdUzQfW2TGsjH3hTu2PH/3JkW
         WaD4NcgTvpOE/wxINRVaQvhrP1N9hBRZDk8q6ycV6+5JOglpqzVlUYx6pJr/dEuTfZ7g
         aoYw==
X-Forwarded-Encrypted: i=1; AJvYcCUdBmlo2LPrcKLt1SIAvhuYvx2Re0GatvRZtsGSdu6zhjfDjP6xTLyHNhxKMmOpEzSVrdzl3enCP48o@vger.kernel.org
X-Gm-Message-State: AOJu0YzYjbNzE+/qzNytazd2DsC3fHw+f4ksiRjKDoiQkm9oI1uVHojA
	P6GrDoeiJbYrd+iG9VQZTh8/qrDmdLpKvU1E8itFgyl3dpLdStZqNGMa731u3GABdFnDEPm2lMy
	g/Ngs65BHJ7hBY2em3WCksgDGZjmZMrqqnm71uRC/
X-Gm-Gg: AZuq6aKGNgooF+QOeEoT0t7olWJ86Ctt010kG2pxeJn6QoRR+phKGWDJ8OAPUAtmVN2
	qfdHGmHOvt5Cj9HU0exKITxlwTV8XcjoPqDRgbjhNdi9hkgNf5pQc28TYAiKQl1IELJbLW3CiMN
	0V7VsWc3/4WS2XtcWJNaDJ7veZLpvmqT3nQgx66aQjKnucnp6A0sRHwl5sFOtiFEpGYiUPAv+5V
	y0lUvI5qqLYhw/nbG+YYFykNPc8cmsnAR54YAaoHE+2BVOUcmk3yWZzU+ip3F03mFrqCudS
X-Received: by 2002:a05:6512:ba3:b0:59e:45a:9075 with SMTP id
 2adb3069b0e04-59e38c63db1mr1571863e87.51.1770234873179; Wed, 04 Feb 2026
 11:54:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net> <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net> <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
 <fff54ec8-496e-4c26-b652-358dc4de0de0@roeck-us.net> <CAK8fFZ4wEUdMAHkfdC_z8ohYB_rEXZ=dHArc75jDibgQ_-ozKw@mail.gmail.com>
 <4f151d4c-fdc6-4281-87b0-b7120eeb1b46@roeck-us.net> <CAK8fFZ401-nez_CgDTTnQiPT=oBRRJuYooXyEKFuCdHpGCPXtA@mail.gmail.com>
 <27d60756-d33e-4926-9a02-f52505339de6@roeck-us.net> <CAK8fFZ43wrQ8A_bO_g+rKN9O31sxULtqA0hUieZSzEH5KqeW1Q@mail.gmail.com>
 <CAJZ5v0hEu_io2BAzp9weUDHwHngorjZ37GRUK=ngSXNjtp38qw@mail.gmail.com>
 <CAK8fFZ65Vro5nQqJq_cvsY93hgDbfTdibWnNr5b0Bixzc-ESfg@mail.gmail.com>
 <CAK8fFZ6Vi4xayvdKh-_eLi-nDNMLuEoMsvwEnb33QqnwS7o4BA@mail.gmail.com> <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
In-Reply-To: <1c8f748a-5c5d-4234-ae86-7bb12045a373@roeck-us.net>
From: Igor Raits <igor@gooddata.com>
Date: Wed, 4 Feb 2026 20:54:19 +0100
X-Gm-Features: AZwV_QgveSowITanEXFcfxtSIf7lZLP9_T4TbSo2OWe8-_QtkzhXAc-Kq-VpMMY
Message-ID: <CA+9S74i+BC3=E0opOPMff0cuC1OPYSecii0C8fVZ+NM7bptNcQ@mail.gmail.com>
Subject: Re: [BISECTED]: acpi_power_meter: power*_average sysfs read hangs,
 mutex deadlock in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: multipart/mixed; boundary="000000000000c9205c064a04ec17"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20854-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igor@gooddata.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[gooddata.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,gooddata.com:email,gooddata.com:dkim]
X-Rspamd-Queue-Id: 16540EC472
X-Rspamd-Action: no action

--000000000000c9205c064a04ec17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have written a patch with the help of AI and it fixes the problem. Attach=
ed.

I don't know how correct it is, but it works :)

On Wed, Feb 4, 2026 at 2:01=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> w=
rote:
>
> On 2/3/26 15:21, Jaroslav Pulchart wrote:
>
> > ...
> > $ git bisect bad
> > bc3a9d217755f65c137f145600f23bf1d6c31ea9 is the first bad commit
> > commit bc3a9d217755f65c137f145600f23bf1d6c31ea9 (HEAD)
> > Author: Corey Minyard <corey@minyard.net>
> > Date:   Wed Aug 20 14:56:50 2025 -0500
> >
> >      ipmi:si: Gracefully handle if the BMC is non-functional
> >
> >      If the BMC is not functional, the driver goes into an error state =
and
> >      starts a 1 second timer.  When the timer times out, it will attemp=
t a
> >      simple message.  If the BMC interacts correctly, the driver will s=
tart
> >      accepting messages again.  If not, it remains in error state.
> >
> >      If the driver goes into error state, all messages current and pend=
ing
> >      will return with an error.
> >
> >      This should more gracefully handle when the BMC becomes non-operat=
ional,
> >      as opposed to trying each messages individually and failing them.
> >
> >      Signed-off-by: Corey Minyard <corey@minyard.net>
> >
> >   drivers/char/ipmi/ipmi_si_intf.c | 29 +++++++++++++++++++++++------
> >   1 file changed, 23 insertions(+), 6 deletions(-)
>
> Now that is interesting. Does reverting that patch on top of 6.18.8
> (or any other 6.18 release) solve the problem ?
>
> Thanks,
> Guenter
>


--=20

Igor Raits | Sr. Technical Manager, Platform Delivery

igor@gooddata.com

+420 775 117 817


Moravske namesti 1007/14

602 00 Brno-Veveri, Czech Republic

--000000000000c9205c064a04ec17
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ipmi-Fix-multiple-races-and-add-timeout-to-prevent-d.patch"
Content-Disposition: attachment; 
	filename="0001-ipmi-Fix-multiple-races-and-add-timeout-to-prevent-d.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ml8g3p3i0>
X-Attachment-Id: f_ml8g3p3i0

RnJvbSAyMThjNzIxMzRkNWE1ZDU1ODQ1ZDA0ZmZjYzJlNTY5OGQ2ZTMxYWJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJZ29yIFJhaXRzIDxpZ29yQGdvb2RkYXRhLmNvbT4KRGF0ZTog
V2VkLCA0IEZlYiAyMDI2IDEwOjQxOjQ1ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gaXBtaTogRml4
IG11bHRpcGxlIHJhY2VzIGFuZCBhZGQgdGltZW91dCB0byBwcmV2ZW50IGRlYWRsb2NrCiB3aGVu
IEJNQyBpcyBzbG93L2hvc2VkCgpXaGVuIHRoZSBCTUMgaXMgbm9uLWZ1bmN0aW9uYWwgb3Igc2xv
dyAoZS5nLiwgZHVyaW5nIGlEUkFDIHJlc2V0KSwKbXVsdGlwbGUgY29kZSBwYXRocyBjb3VsZCBs
ZWF2ZSBJUE1JIG1lc3NhZ2VzIHdpdGhvdXQgcmVzcG9uc2VzLCBjYXVzaW5nCmNhbGxlcnMgdG8g
YmxvY2sgaW5kZWZpbml0ZWx5LgoKSW4gdGhlIFNJIGRyaXZlciAoaXBtaV9zaV9pbnRmLmMpLCBm
aXggdGhyZWUgcmFjZXM6CgoxLiBUaGUgc2VuZGVyKCkgY2FsbGJhY2sgcmV0dXJucyBhbiBlcnJv
ciAoSVBNSV9CVVNfRVJSKSBpbW1lZGlhdGVseSwKICAgYnV0IHNtaV9zZW5kKCkgaW4gaXBtaV9t
c2doYW5kbGVyLmMgd2FzIGlnbm9yaW5nIHRoaXMgcmV0dXJuIHZhbHVlLAogICBtZWFuaW5nIG5v
IGVycm9yIHJlc3BvbnNlIHdhcyBkZWxpdmVyZWQgdG8gd2FpdGluZyBjYWxsZXJzLgoKMi4gV2hl
biBlbnRlcmluZyBTSV9IT1NFRCBzdGF0ZSwgb25seSBjdXJyX21zZyB3YXMgcmV0dXJuZWQgd2l0
aCBhbgogICBlcnJvciByZXNwb25zZS4gSWYgdGhlcmUgd2FzIGEgd2FpdGluZ19tc2cgcXVldWVk
LCBpdCB3b3VsZCBiZQogICBvcnBoYW5lZCBhbmQgbmV2ZXIgcmVjZWl2ZSBhIHJlc3BvbnNlLgoK
My4gVGhlIFNJX0hPU0VEIGNoZWNrIGluIHNlbmRlcigpIHdhcyBkb25lIG91dHNpZGUgdGhlIHNp
X2xvY2ssCiAgIGNyZWF0aW5nIGEgcmFjZSB3aW5kb3cgd2hlcmU6CiAgIC0gc2VuZGVyKCkgY2hl
Y2tzIFNJX0hPU0VEIChub3QgaG9zZWQpIG91dHNpZGUgbG9jawogICAtIHNtaV9ldmVudF9oYW5k
bGVyKCkgdW5kZXIgbG9jayBzZXRzIFNJX0hPU0VEIGFuZCBoYW5kbGVzIHdhaXRpbmdfbXNnCiAg
IC0gc2VuZGVyKCkgdGFrZXMgbG9jayBhbmQgc2V0cyB3YWl0aW5nX21zZwogICAtIE1lc3NhZ2Ug
aXMgb3JwaGFuZWQgc2luY2UgaG9zZWQgaGFuZGxlciBhbHJlYWR5IHJhbgoKQWRkaXRpb25hbGx5
LCBpbiBhY3BpX2lwbWkuYywgdGhlIHdhaXRfZm9yX2NvbXBsZXRpb24oKSBoYWQgbm8gdGltZW91
dCwKc28gaWYgdGhlIEJNQyB3YXMgc2xvdyAoYnV0IG5vdCBjb21wbGV0ZWx5IGRlYWQsIGUuZy4s
IGR1cmluZyBpRFJBQwpyZXNldCksIHRoZSBBQ1BJIElQTUkgaGFuZGxlciB3b3VsZCBibG9jayBp
bmRlZmluaXRlbHkuIFRoaXMgY2F1c2VkCmh1bmcgdGFza3MgaW4gaHdtb24gYXR0cmlidXRlIHJl
YWRzIHRoYXQgdXNlIEFDUEkgbWV0aG9kcyBhY2Nlc3NpbmcKSVBNSS4gQWRkIGEgMTUtc2Vjb25k
IHRpbWVvdXQgKDN4IElQTUlfVElNRU9VVCkgdG8gcHJldmVudCB0aGlzLgoKRml4ZXM6IGJjM2E5
ZDIxNzc1NSAoImlwbWk6c2k6IEdyYWNlZnVsbHkgaGFuZGxlIGlmIHRoZSBCTUMgaXMgbm9uLWZ1
bmN0aW9uYWwiKQpSZXBvcnRlZC1hbmQtYmlzZWN0ZWQtYnk6IEphcm9zbGF2IFB1bGNoYXJ0IDxq
YXJvc2xhdi5wdWxjaGFydEBnb29kZGF0YS5jb20+ClNpZ25lZC1vZmYtYnk6IElnb3IgUmFpdHMg
PGlnb3JAZ29vZGRhdGEuY29tPgotLS0KIGRyaXZlcnMvYWNwaS9hY3BpX2lwbWkuYyAgICAgICAg
ICAgIHwgMTMgKysrKysrKysrKysrLQogZHJpdmVycy9jaGFyL2lwbWkvaXBtaV9tc2doYW5kbGVy
LmMgfCAxOSArKysrKysrKysrKysrKysrKy0tCiBkcml2ZXJzL2NoYXIvaXBtaS9pcG1pX3NpX2lu
dGYuYyAgICB8IDI2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQs
IDQ3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YWNwaS9hY3BpX2lwbWkuYyBiL2RyaXZlcnMvYWNwaS9hY3BpX2lwbWkuYwppbmRleCA1ZmJhNGRh
YjVkMDguLmFiMWY0YjI3NzQxZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9hY3BpL2FjcGlfaXBtaS5j
CisrKyBiL2RyaXZlcnMvYWNwaS9hY3BpX2lwbWkuYwpAQCAtNTcyLDcgKzU3MiwxOCBAQCBhY3Bp
X2lwbWlfc3BhY2VfaGFuZGxlcih1MzIgZnVuY3Rpb24sIGFjcGlfcGh5c2ljYWxfYWRkcmVzcyBh
ZGRyZXNzLAogCQlzdGF0dXMgPSBBRV9FUlJPUjsKIAkJZ290byBvdXRfbXNnOwogCX0KLQl3YWl0
X2Zvcl9jb21wbGV0aW9uKCZ0eF9tc2ctPnR4X2NvbXBsZXRlKTsKKworCS8qCisJICogVXNlIGEg
dGltZW91dCB0byBhdm9pZCBibG9ja2luZyBmb3JldmVyIGlmIHRoZSBCTUMgaXMgc2xvdworCSAq
IG9yIG5vbi1yZXNwb25zaXZlIChlLmcuLCBkdXJpbmcgaURSQUMgcmVzZXQpLiBUaGUgdGltZW91
dAorCSAqIHNob3VsZCBiZSBsb25nZXIgdGhhbiBJUE1JX1RJTUVPVVQgdG8gYWxsb3cgZm9yIHJl
dHJpZXMuCisJICovCisJaWYgKCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJnR4X21zZy0+
dHhfY29tcGxldGUsCisJCQkJCSBtc2Vjc190b19qaWZmaWVzKElQTUlfVElNRU9VVCAqIDMpKSkg
eworCQlkZXZfd2Fybl9vbmNlKGlwbWlfZGV2aWNlLT5kZXYsCisJCQkgICAgICAiQUNQSSBJUE1J
IHJlcXVlc3QgdGltZWQgb3V0XG4iKTsKKwkJdHhfbXNnLT5tc2dfZG9uZSA9IEFDUElfSVBNSV9U
SU1FT1VUOworCX0KIAogCWFjcGlfZm9ybWF0X2lwbWlfcmVzcG9uc2UodHhfbXNnLCB2YWx1ZSk7
CiAJc3RhdHVzID0gQUVfT0s7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX21z
Z2hhbmRsZXIuYyBiL2RyaXZlcnMvY2hhci9pcG1pL2lwbWlfbXNnaGFuZGxlci5jCmluZGV4IDM3
MDBhYjRlYmEzZS4uYTRlZTI4ZjEzNjE1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9p
cG1pX21zZ2hhbmRsZXIuYworKysgYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX21zZ2hhbmRsZXIu
YwpAQCAtMTg3Niw2ICsxODc2LDcgQEAgc3RhdGljIHZvaWQgc21pX3NlbmQoc3RydWN0IGlwbWlf
c21pICppbnRmLAogewogCWludCBydW5fdG9fY29tcGxldGlvbiA9IFJFQURfT05DRShpbnRmLT5y
dW5fdG9fY29tcGxldGlvbik7CiAJdW5zaWduZWQgbG9uZyBmbGFncyA9IDA7CisJaW50IHJ2Owog
CiAJaWYgKCFydW5fdG9fY29tcGxldGlvbikKIAkJc3Bpbl9sb2NrX2lycXNhdmUoJmludGYtPnht
aXRfbXNnc19sb2NrLCBmbGFncyk7CkBAIC0xODgzLDggKzE4ODQsMjIgQEAgc3RhdGljIHZvaWQg
c21pX3NlbmQoc3RydWN0IGlwbWlfc21pICppbnRmLAogCWlmICghcnVuX3RvX2NvbXBsZXRpb24p
CiAJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmludGYtPnhtaXRfbXNnc19sb2NrLCBmbGFncyk7
CiAKLQlpZiAoc21pX21zZykKLQkJaGFuZGxlcnMtPnNlbmRlcihpbnRmLT5zZW5kX2luZm8sIHNt
aV9tc2cpOworCWlmIChzbWlfbXNnKSB7CisJCXJ2ID0gaGFuZGxlcnMtPnNlbmRlcihpbnRmLT5z
ZW5kX2luZm8sIHNtaV9tc2cpOworCQlpZiAocnYpIHsKKwkJCS8qCisJCQkgKiBUaGUgc2VuZGVy
KCkgZmFpbGVkIChlLmcuLCBCTUMgaW4gaG9zZWQgc3RhdGUpLgorCQkJICogRGVsaXZlciBhbiBl
cnJvciByZXNwb25zZSBzbyBjYWxsZXJzIGRvbid0IGJsb2NrCisJCQkgKiBpbmRlZmluaXRlbHkg
d2FpdGluZyBmb3IgYSByZXNwb25zZSB0aGF0IHdpbGwKKwkJCSAqIG5ldmVyIGNvbWUuCisJCQkg
Ki8KKwkJCWlmIChzbWlfbXNnLT5yZWN2X21zZykKKwkJCQlkZWxpdmVyX2Vycl9yZXNwb25zZShp
bnRmLCBzbWlfbXNnLT5yZWN2X21zZywKKwkJCQkJCSAgICAgcnYpOworCQkJZWxzZQorCQkJCWlw
bWlfZnJlZV9zbWlfbXNnKHNtaV9tc2cpOworCQl9CisJfQogfQogCiBzdGF0aWMgYm9vbCBpc19t
YWludGVuYW5jZV9tb2RlX2NtZChzdHJ1Y3Qga2VybmVsX2lwbWlfbXNnICptc2cpCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX3NpX2ludGYuYyBiL2RyaXZlcnMvY2hhci9pcG1p
L2lwbWlfc2lfaW50Zi5jCmluZGV4IDcwZTU1ZjVmZjg1ZS4uNjk4ZGQ0MDcyYWY1IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX3NpX2ludGYuYworKysgYi9kcml2ZXJzL2NoYXIv
aXBtaS9pcG1pX3NpX2ludGYuYwpAQCAtODEwLDYgKzgxMCwxNSBAQCBzdGF0aWMgZW51bSBzaV9z
bV9yZXN1bHQgc21pX2V2ZW50X2hhbmRsZXIoc3RydWN0IHNtaV9pbmZvICpzbWlfaW5mbywKIAkJ
CSAqLwogCQkJcmV0dXJuX2hvc2VkX21zZyhzbWlfaW5mbywgSVBNSV9CVVNfRVJSKTsKIAkJfQor
CQlpZiAoc21pX2luZm8tPndhaXRpbmdfbXNnICE9IE5VTEwpIHsKKwkJCS8qCisJCQkgKiBJZiB0
aGVyZSdzIGEgd2FpdGluZyBtZXNzYWdlLCByZXR1cm4gaXQgd2l0aAorCQkJICogZXJyb3IgdG9v
IHNvIGNhbGxlcnMgZG9uJ3QgYmxvY2sgaW5kZWZpbml0ZWx5LgorCQkJICovCisJCQlzbWlfaW5m
by0+Y3Vycl9tc2cgPSBzbWlfaW5mby0+d2FpdGluZ19tc2c7CisJCQlzbWlfaW5mby0+d2FpdGlu
Z19tc2cgPSBOVUxMOworCQkJcmV0dXJuX2hvc2VkX21zZyhzbWlfaW5mbywgSVBNSV9CVVNfRVJS
KTsKKwkJfQogCQlzbWlfbW9kX3RpbWVyKHNtaV9pbmZvLCBqaWZmaWVzICsgU0lfVElNRU9VVF9I
T1NFRCk7CiAJCWdvdG8gb3V0OwogCX0KQEAgLTkyMiwyNiArOTMxLDI3IEBAIHN0YXRpYyBpbnQg
c2VuZGVyKHZvaWQgKnNlbmRfaW5mbywgc3RydWN0IGlwbWlfc21pX21zZyAqbXNnKQogCiAJZGVi
dWdfdGltZXN0YW1wKHNtaV9pbmZvLCAiRW5xdWV1ZSIpOwogCi0JaWYgKHNtaV9pbmZvLT5zaV9z
dGF0ZSA9PSBTSV9IT1NFRCkKLQkJcmV0dXJuIElQTUlfQlVTX0VSUjsKLQogCWlmIChzbWlfaW5m
by0+cnVuX3RvX2NvbXBsZXRpb24pIHsKIAkJLyoKIAkJICogSWYgd2UgYXJlIHJ1bm5pbmcgdG8g
Y29tcGxldGlvbiwgc3RhcnQgaXQuICBVcHBlcgogCQkgKiBsYXllciB3aWxsIGNhbGwgZmx1c2hf
bWVzc2FnZXMgdG8gY2xlYXIgaXQgb3V0LgogCQkgKi8KKwkJaWYgKHNtaV9pbmZvLT5zaV9zdGF0
ZSA9PSBTSV9IT1NFRCkKKwkJCXJldHVybiBJUE1JX0JVU19FUlI7CiAJCXNtaV9pbmZvLT53YWl0
aW5nX21zZyA9IG1zZzsKIAkJcmV0dXJuIElQTUlfQ0NfTk9fRVJST1I7CiAJfQogCiAJc3Bpbl9s
b2NrX2lycXNhdmUoJnNtaV9pbmZvLT5zaV9sb2NrLCBmbGFncyk7CiAJLyoKLQkgKiBUaGUgZm9s
bG93aW5nIHR3byBsaW5lcyBkb24ndCBuZWVkIHRvIGJlIHVuZGVyIHRoZSBsb2NrIGZvcgotCSAq
IHRoZSBsb2NrJ3Mgc2FrZSwgYnV0IHRoZXkgZG8gbmVlZCBTTVAgbWVtb3J5IGJhcnJpZXJzIHRv
Ci0JICogYXZvaWQgZ2V0dGluZyB0aGluZ3Mgb3V0IG9mIG9yZGVyLiAgV2UgYXJlIGFscmVhZHkg
Y2xhaW1pbmcKLQkgKiB0aGUgbG9jaywgYW55d2F5LCBzbyBqdXN0IGRvIGl0IHVuZGVyIHRoZSBs
b2NrIHRvIGF2b2lkIHRoZQotCSAqIG9yZGVyaW5nIHByb2JsZW0uCisJICogQ2hlY2sgU0lfSE9T
RUQgdW5kZXIgdGhlIGxvY2sgdG8gYXZvaWQgcmFjZSB3aXRoCisJICogc21pX2V2ZW50X2hhbmRs
ZXIoKSB3aGljaCBhbHNvIGhhbmRsZXMgd2FpdGluZ19tc2cKKwkgKiB1bmRlciB0aGlzIGxvY2sg
d2hlbiBlbnRlcmluZyBob3NlZCBzdGF0ZS4KIAkgKi8KKwlpZiAoc21pX2luZm8tPnNpX3N0YXRl
ID09IFNJX0hPU0VEKSB7CisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnNtaV9pbmZvLT5zaV9s
b2NrLCBmbGFncyk7CisJCXJldHVybiBJUE1JX0JVU19FUlI7CisJfQogCUJVR19PTihzbWlfaW5m
by0+d2FpdGluZ19tc2cpOwogCXNtaV9pbmZvLT53YWl0aW5nX21zZyA9IG1zZzsKIAljaGVja19z
dGFydF90aW1lcl90aHJlYWQoc21pX2luZm8pOwotLSAKMi41Mi4wCgo=
--000000000000c9205c064a04ec17--

