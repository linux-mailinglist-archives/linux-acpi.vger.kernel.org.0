Return-Path: <linux-acpi+bounces-1405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8204C7E7C30
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 13:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D9C281389
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D2C1A5BC
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbi7lSM6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712818B0D
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 12:19:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C48033663
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 04:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699618751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d1whh53T9s+HtqGbyLHv3NqyFPtaLB/zMBiip1Dm8eo=;
	b=dbi7lSM6J8PqzPomCnh6XhJFB+k3VjCZ72NQZxmBfUylvwsaR/5vRifDbcOKdvb8xKZ/kx
	S7JGm8KEgj6X4hVOw3h8M9BLzugr6iXeGA+v/xhVJBNgIA/eav94EwqpanE25UdsS+IATP
	2WIXJ/nmrzkrF9GoFsKC2t/ahkD6mno=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-tczFZCtCPaypR64iGhVsOQ-1; Fri, 10 Nov 2023 07:19:09 -0500
X-MC-Unique: tczFZCtCPaypR64iGhVsOQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9e5e190458dso96918566b.1
        for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 04:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699618749; x=1700223549;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1whh53T9s+HtqGbyLHv3NqyFPtaLB/zMBiip1Dm8eo=;
        b=AQRAmx+Qax6P/8QGpMYBpDGhuTI55Z4boOQkyjG4my3QqE1o5woZwWjgUaQ5je8u9J
         a5NwTWQiaIv9Mgv8945+cDXhM22Mwd7KME/ko/NjBxrbXKYYL6mzdtNJ1kfJ4CVg3/tl
         NoJk9+KmeH2+CPr9SX+uJBN2N6dED3JbT0dFSreYRIuOgTlpMEpjASAZy4RqeVxf7/0t
         IICmoRvgVODAqCNBm+mYjzrk0SLJcYMczE1CLbfiLk0ml1kUl1sqkRod+/PzR5QmvLT+
         n6pWESizAZMd5d/fhASwf8b0ez8L7woZ6wdM3dY9V2hLu4W7k9xuvpNRMOhCCp/3iMoo
         lnuA==
X-Gm-Message-State: AOJu0YxaKJKADMUIgTzPQFMrdfGtNU3kefbaW0gbq9HSlRLfmGKIbL7+
	Qk/p9Fh5oknbmZgjYM0Exn4exdvggns1r+XBxun7wM/wSpVgn0Cj5j+TJrkCUzstDUo2iEDL0DH
	0D5VPWGJlrHrEAtswKyRCFQ==
X-Received: by 2002:a17:906:348f:b0:9ad:e3fd:d46c with SMTP id g15-20020a170906348f00b009ade3fdd46cmr1983869ejb.10.1699618748797;
        Fri, 10 Nov 2023 04:19:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFUJSuoTddDVUnMW1xL9VJXCGY/Zir1gl4CSrzPZps3UPSDo0azFQEhVUlzVS/F/HdESVfYg==
X-Received: by 2002:a17:906:348f:b0:9ad:e3fd:d46c with SMTP id g15-20020a170906348f00b009ade3fdd46cmr1983844ejb.10.1699618748423;
        Fri, 10 Nov 2023 04:19:08 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id e14-20020a1709061e8e00b00977cad140a8sm3867371ejj.218.2023.11.10.04.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 04:19:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------iOgSsRA60Wlx910hYRXi01Ux"
Message-ID: <a592ce0c-64f0-477d-80fa-8f5a52ba29ea@redhat.com>
Date: Fri, 10 Nov 2023 13:19:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
Content-Language: en-US, nl
To: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Owen T. Heisler" <writer@owenh.net>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
References: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
 <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAAd53p7BSesx=a1igTohoSkxrW+Hq8O7ArONFCK7uoDi12-T4A@mail.gmail.com>

This is a multi-part message in MIME format.
--------------iOgSsRA60Wlx910hYRXi01Ux
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

On 11/10/23 07:09, Kai-Heng Feng wrote:
> Hi Owen,
> 
> On Fri, Nov 10, 2023 at 5:55 AM Owen T. Heisler <writer@owenh.net> wrote:
>>
>> #regzbot introduced: 89c290ea758911e660878e26270e084d862c03b0
>> #regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
>> #regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218124
> 
> Thanks for the bug report. Do you prefer to continue the discussion
> here, on gitlab or on bugzilla?

Owen, as Kai-Heng said thank you for reporting this.

>> ## Reproducing
>>
>> 1. Boot system to framebuffer console.
>> 2. Run `systemctl suspend`. If undocked without secondary display,
>> suspend fails. If docked with secondary display, suspend succeeds.
>> 3. Resume from suspend if applicable.
>> 4. System is now in a broken state.
> 
> So I guess we need to put those devices to ACPI D3 for suspend. Let's
> discuss this on your preferred platform.

Ok, so I was already sort of afraid we might see something like this
happening because of:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=89c290ea758911e660878e26270e084d862c03b0

As I mentioned during the review of that, it might be better to
not touch the video-card ACPI power-state at all and instead
only do acpi_device_fix_up_power() on the child devices.

Owen, attached are 2 patches which implement only
calling acpi_device_fix_up_power() on the child devices,
can you build a v6.6 kernel with these 2 patches added
on top please and see if that fixes things ?

Kai-Heng can you test that the issue on the HP ZBook Fury 16 G10
is still resolved after applying these patches ?

Regards,

Hans


--------------iOgSsRA60Wlx910hYRXi01Ux
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-PM-Add-acpi_device_fix_up_power_children-functi.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-PM-Add-acpi_device_fix_up_power_children-functi.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2OGE4MTkxMDFjNTgwYmI4OWYzNGEzMTE5NmFjZTgxMjQ0Y2E4ZWI1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBGcmksIDEwIE5vdiAyMDIzIDEyOjUyOjM5ICswMTAwClN1YmplY3Q6IFtQ
QVRDSCAxLzJdIEFDUEk6IFBNOiBBZGQgYWNwaV9kZXZpY2VfZml4X3VwX3Bvd2VyX2NoaWxk
cmVuKCkKIGZ1bmN0aW9uCgpJbiBzb21lIGNhc2VzIGl0IGlzIG5lY2Vzc2FyeSB0byBmaXgt
dXAgdGhlIHBvd2VyLXN0YXRlIG9mIGFuIEFDUEkKZGV2aWNlJ3MgY2hpbGRyZW4gd2l0aG91
dCB0b3VjaGluZyB0aGUgQUNQSSBkZXZpY2UgaXRzZWxmIGFkZAphIG5ldyBhY3BpX2Rldmlj
ZV9maXhfdXBfcG93ZXJfY2hpbGRyZW4oKSBmdW5jdGlvbiBmb3IgdGhpcy4KClNpZ25lZC1v
ZmYtYnk6IEhhbnMgZGUgR29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVy
cy9hY3BpL2RldmljZV9wbS5jIHwgMTMgKysrKysrKysrKysrKwogaW5jbHVkZS9hY3BpL2Fj
cGlfYnVzLmggIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2RldmljZV9wbS5jIGIvZHJpdmVycy9hY3BpL2Rl
dmljZV9wbS5jCmluZGV4IGYwMDcxMTZhODQyNy4uM2I0ZDA0OGM0OTQxIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2FjcGkvZGV2aWNlX3BtLmMKKysrIGIvZHJpdmVycy9hY3BpL2RldmljZV9w
bS5jCkBAIC0zOTcsNiArMzk3LDE5IEBAIHZvaWQgYWNwaV9kZXZpY2VfZml4X3VwX3Bvd2Vy
X2V4dGVuZGVkKHN0cnVjdCBhY3BpX2RldmljZSAqYWRldikKIH0KIEVYUE9SVF9TWU1CT0xf
R1BMKGFjcGlfZGV2aWNlX2ZpeF91cF9wb3dlcl9leHRlbmRlZCk7CiAKKy8qKgorICogYWNw
aV9kZXZpY2VfZml4X3VwX3Bvd2VyX2NoaWxkcmVuIC0gRm9yY2UgYSBkZXZpY2UncyBjaGls
ZHJlbiBpbnRvIEQwLgorICogQGFkZXY6IFBhcmVudCBkZXZpY2Ugb2JqZWN0IHdob3NlIGNo
aWxkcmVuJ3MgcG93ZXIgc3RhdGUgaXMgdG8gYmUgZml4ZWQgdXAuCisgKgorICogQ2FsbCBh
Y3BpX2RldmljZV9maXhfdXBfcG93ZXIoKSBmb3IgQGFkZXYncyBjaGlsZHJlbiBzbyBsb25n
IGFzIHRoZXkKKyAqIGFyZSByZXBvcnRlZCBhcyBwcmVzZW50IGFuZCBlbmFibGVkLgorICov
Cit2b2lkIGFjcGlfZGV2aWNlX2ZpeF91cF9wb3dlcl9jaGlsZHJlbihzdHJ1Y3QgYWNwaV9k
ZXZpY2UgKmFkZXYpCit7CisJYWNwaV9kZXZfZm9yX2VhY2hfY2hpbGQoYWRldiwgZml4X3Vw
X3Bvd2VyX2lmX2FwcGxpY2FibGUsIE5VTEwpOworfQorRVhQT1JUX1NZTUJPTF9HUEwoYWNw
aV9kZXZpY2VfZml4X3VwX3Bvd2VyX2NoaWxkcmVuKTsKKwogaW50IGFjcGlfZGV2aWNlX3Vw
ZGF0ZV9wb3dlcihzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50ICpzdGF0ZV9wKQog
ewogCWludCBzdGF0ZTsKZGlmZiAtLWdpdCBhL2luY2x1ZGUvYWNwaS9hY3BpX2J1cy5oIGIv
aW5jbHVkZS9hY3BpL2FjcGlfYnVzLmgKaW5kZXggMjU0Njg1MDg1YzgyLi4wYjdlYWIwZWY3
ZDcgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYWNwaS9hY3BpX2J1cy5oCisrKyBiL2luY2x1ZGUv
YWNwaS9hY3BpX2J1cy5oCkBAIC01MzksNiArNTM5LDcgQEAgaW50IGFjcGlfZGV2aWNlX3Nl
dF9wb3dlcihzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSwgaW50IHN0YXRlKTsKIGludCBh
Y3BpX2J1c19pbml0X3Bvd2VyKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlKTsKIGludCBh
Y3BpX2RldmljZV9maXhfdXBfcG93ZXIoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UpOwog
dm9pZCBhY3BpX2RldmljZV9maXhfdXBfcG93ZXJfZXh0ZW5kZWQoc3RydWN0IGFjcGlfZGV2
aWNlICphZGV2KTsKK3ZvaWQgYWNwaV9kZXZpY2VfZml4X3VwX3Bvd2VyX2NoaWxkcmVuKHN0
cnVjdCBhY3BpX2RldmljZSAqYWRldik7CiBpbnQgYWNwaV9idXNfdXBkYXRlX3Bvd2VyKGFj
cGlfaGFuZGxlIGhhbmRsZSwgaW50ICpzdGF0ZV9wKTsKIGludCBhY3BpX2RldmljZV91cGRh
dGVfcG93ZXIoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UsIGludCAqc3RhdGVfcCk7CiBi
b29sIGFjcGlfYnVzX3Bvd2VyX21hbmFnZWFibGUoYWNwaV9oYW5kbGUgaGFuZGxlKTsKLS0g
CjIuNDEuMAoK
--------------iOgSsRA60Wlx910hYRXi01Ux
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-ACPI-video-Use-acpi_device_fix_up_power_children.patch"
Content-Disposition: attachment;
 filename*0="0002-ACPI-video-Use-acpi_device_fix_up_power_children.patch"
Content-Transfer-Encoding: base64

RnJvbSAzM2UyZDU1OTE3YWM3MDgyZThkOThkYzJhNjc4YTg1NmY4ZDQ4MzUyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBGcmksIDEwIE5vdiAyMDIzIDEzOjEwOjAyICswMTAwClN1YmplY3Q6IFtQ
QVRDSCAyLzJdIEFDUEk6IHZpZGVvOiBVc2UgYWNwaV9kZXZpY2VfZml4X3VwX3Bvd2VyX2No
aWxkcmVuKCkKCkNvbW1pdCA4OWMyOTBlYTc1ODkgKCJBQ1BJOiB2aWRlbzogUHV0IEFDUEkg
dmlkZW8gYW5kIGl0cyBjaGlsZCBkZXZpY2VzCmludG8gRDAgb24gYm9vdCIpIGludHJvZHVj
ZWQgY2FsbGluZyBhY3BpX2RldmljZV9maXhfdXBfcG93ZXJfZXh0ZW5kZWQoKQpvbiB0aGUg
dmlkZW8gY2FyZCBmb3Igd2hpY2ggdGhlIEFDUEkgdmlkZW8gYnVzIGlzIHRoZSBjb21wYW5p
b24gZGV2aWNlLgoKVGhpcyB1bm5lY2Vzc2FyaWx5IHRvdWNoZXMgdGhlIHBvd2VyLXN0YXRl
IG9mIHRoZSBHUFUgaXRzZWxmLCB3aGlsZQp0aGUgaXNzdWUgaXQgdHJpZXMgdG8gYWRkcmVz
cyBvbmx5IHJlcXVpcmVzIGNhbGxpbmcgX1BTMCBvbiB0aGUgY2hpbGQKZGV2aWNlcy4KClRv
dWNoaW5nIHRoZSBwb3dlci1zdGF0ZSBvZiB0aGUgR1BVIGl0c2VsZiBpcyBjYXVzaW5nIHN1
c3BlbmQgLyByZXN1bWUKaXNzdWVzIG9uIGUuZy4gYSBMZW5vdm8gVGhpbmtQYWQgVzUzMC4K
Ckluc3RlYWQgdXNlIGFjcGlfZGV2aWNlX2ZpeF91cF9wb3dlcl9jaGlsZHJlbigpLCB3aGlj
aCBvbmx5IHRvdWNoZXMKdGhlIGNoaWxkIGRldmljZXMsIHRvIGZpeCB0aGlzLgoKRml4ZXM6
IDg5YzI5MGVhNzU4OSAoIkFDUEk6IHZpZGVvOiBQdXQgQUNQSSB2aWRlbyBhbmQgaXRzIGNo
aWxkIGRldmljZXMgaW50byBEMCBvbiBib290IikKUmVwb3J0ZWQtYnk6IE93ZW4gVC4gSGVp
c2xlciA8d3JpdGVyQG93ZW5oLm5ldD4KQ2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVz
a3RvcC5vcmcvZHJtL25vdXZlYXUvLS9pc3N1ZXMvMjczCkNsb3NlczogaHR0cHM6Ly9idWd6
aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTgxMjQKU2lnbmVkLW9mZi1ieTog
SGFucyBkZSBHb2VkZSA8aGRlZ29lZGVAcmVkaGF0LmNvbT4KLS0tCiBkcml2ZXJzL2FjcGkv
YWNwaV92aWRlby5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2FjcGlfdmlkZW8uYyBi
L2RyaXZlcnMvYWNwaS9hY3BpX3ZpZGVvLmMKaW5kZXggYjQxMTk0ODU5NGZmLi40ZTg2ODQ1
NGIzOGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpX3ZpZGVvLmMKKysrIGIvZHJp
dmVycy9hY3BpL2FjcGlfdmlkZW8uYwpAQCAtMjAzMSw3ICsyMDMxLDcgQEAgc3RhdGljIGlu
dCBhY3BpX3ZpZGVvX2J1c19hZGQoc3RydWN0IGFjcGlfZGV2aWNlICpkZXZpY2UpCiAJICog
SFAgWkJvb2sgRnVyeSAxNiBHMTAgcmVxdWlyZXMgQUNQSSB2aWRlbydzIGNoaWxkIGRldmlj
ZXMgaGF2ZSBfUFMwCiAJICogZXZhbHVhdGVkIHRvIGhhdmUgZnVuY3Rpb25hbCBwYW5lbCBi
cmlnaHRuZXNzIGNvbnRyb2wuCiAJICovCi0JYWNwaV9kZXZpY2VfZml4X3VwX3Bvd2VyX2V4
dGVuZGVkKGRldmljZSk7CisJYWNwaV9kZXZpY2VfZml4X3VwX3Bvd2VyX2NoaWxkcmVuKGRl
dmljZSk7CiAKIAlwcl9pbmZvKCIlcyBbJXNdIChtdWx0aS1oZWFkOiAlcyAgcm9tOiAlcyAg
cG9zdDogJXMpXG4iLAogCSAgICAgICBBQ1BJX1ZJREVPX0RFVklDRV9OQU1FLCBhY3BpX2Rl
dmljZV9iaWQoZGV2aWNlKSwKLS0gCjIuNDEuMAoK

--------------iOgSsRA60Wlx910hYRXi01Ux--


