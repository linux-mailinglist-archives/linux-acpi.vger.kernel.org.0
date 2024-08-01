Return-Path: <linux-acpi+bounces-7203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE7944A2F
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 13:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAE91C2161D
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80054183CD1;
	Thu,  1 Aug 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBNouKZV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D841332A1
	for <linux-acpi@vger.kernel.org>; Thu,  1 Aug 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510933; cv=none; b=Zv4BmpIJVrIJYaJdo99ClVshx08ZKCCYoYXd6cpXRClLD7Fw8tkSlDpogKw7464K+g0TcZ8NA0zeq4K+IobnUujyJLKTViAQHDNYxzdWIz9QoTxqGbiiF7WGTmXuMIegGj+i4YZtfWtbvGKUbakT1gY5yaYe4ignArAyo1izOX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510933; c=relaxed/simple;
	bh=DZuLbWdtR1LFrDVvhnhDAMHMppWAoVF9xyXrTScB+7g=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=UdluUdCVs9b8JUGjpngxXth34KpaoLuFinulXDFOn8Dw2T1zCtd1SVjRauos6r9uxZG8r18c805NfUwRzbvwoSF5J14V4IgsUOq81EFYj1GN6tkxWOAysBZ2Ctqa7VTBMyDHyMz43kH1++D+Ou1dsnaZUxJsWAaLQFyxJ1wOkWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBNouKZV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722510930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVzbTyhlxFVQMQHPVPVyLKZRbWjJKGAeQ7HquivUjSs=;
	b=gBNouKZVRBK35NPK2x2AXxs5T2s648ygAZdifIlFaSQn5WZlw5Hmtj91F3xVktCk1NJ5BM
	PBnsBuUSkfOHVGvMg+CNA5zCc4m2MWyIYhJPNUovZC/aqXIM4r7Hn5x9wphIWRu+MnYN4A
	jQVzOfmi48PbLasXBUTcPGFiGmrwKxM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-b8MXhdGgPfaBnarwFOX2Eg-1; Thu, 01 Aug 2024 07:15:28 -0400
X-MC-Unique: b8MXhdGgPfaBnarwFOX2Eg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a77f0eca75bso630387666b.1
        for <linux-acpi@vger.kernel.org>; Thu, 01 Aug 2024 04:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510927; x=1723115727;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WVzbTyhlxFVQMQHPVPVyLKZRbWjJKGAeQ7HquivUjSs=;
        b=BoYCHVoWk89CPF7Dntiky3Sgi4ZwweR66fwjwfPiEIqUwZGMjmEP0a+qflZ7Qo/4hP
         NU3Cd0Ug8ISlEPvkUzWFUZHS2rWd1Qm3kakd4RM6KOo7xV75ShaBlQw/9CF1Xsb41V2M
         fWFeQyROVVLWttz6ZW9KuT92xV+Nkh3fiGTs7+Fx6utWNQGSMSw7FjrsfJo46EbqJtrc
         s2HslpWa/Wlo9LGJhPrlleR9QrpqhtSR4MhUhempoiH/gw9J/M9r1c1UBVAwN4vnQAl1
         PKk6NHY4a3TaW8jXjqBwgNe6kMyNb5c+8H6hk/sNR3FngwMUqse1scWXbLKrYRMg2niW
         o0dg==
X-Gm-Message-State: AOJu0YyBMOczdzzR+Zu29DvFU7GpdrQlbHzbfiNp2mLePhvzJ+j9+UyJ
	9j1f4OT16rVbUwP+P4PbNkv19Iu9IhzPqt9mQx7XEIvPvAJrkfG33h4lGJEEHAd2nooFaHyg+dq
	O6/hBG3IqCsS9HIApv/yi/xKIgQeVTFM6oZY4Z/hSvLXVYw9tvd0/wbHFvwQrZXXUxng=
X-Received: by 2002:a17:907:1c19:b0:a7a:929f:c0cb with SMTP id a640c23a62f3a-a7daf50bee9mr168722666b.38.1722510926730;
        Thu, 01 Aug 2024 04:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEne3Sp4UeE4LIRLMLZkCIIVq/vOFjdMUF9sROuoJvZ2i/aHWYzhUTAWehp57+3sFgHvSDNrw==
X-Received: by 2002:a17:907:1c19:b0:a7a:929f:c0cb with SMTP id a640c23a62f3a-a7daf50bee9mr168720966b.38.1722510926122;
        Thu, 01 Aug 2024 04:15:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadbb8fasm887895966b.224.2024.08.01.04.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 04:15:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------IZCZo02FBIWBScZMNZdUm28D"
Message-ID: <9db23330-8ba7-446b-8626-c715b61fd8a5@redhat.com>
Date: Thu, 1 Aug 2024 13:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <6dfb58d7-0b36-4414-bc01-75697077fd27@redhat.com>
 <CAJZ5v0gs-qrywWyF7PXC7_b0zAfBz=8xoc5V83nkuWgt0RdV9A@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gs-qrywWyF7PXC7_b0zAfBz=8xoc5V83nkuWgt0RdV9A@mail.gmail.com>

This is a multi-part message in MIME format.
--------------IZCZo02FBIWBScZMNZdUm28D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 7/29/24 2:20 PM, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Mon, Jul 29, 2024 at 1:29 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 7/29/24 1:15 PM, Hans de Goede wrote:
>>> Hi Rafael,
>>>
>>> There are 2 bug reports:
>>>
>>> 1. Brightness up/down key-presses no longer working on LG laptop (acpi-video related):
>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
>>>
>>> 2. EC related ACPI errors and bad performance:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2298938
>>>
>>> Both of which started with 6.9.7 which has the 2 commits related to "EC: Install
>>> address space handler at the namespace root" from 6.10 backported:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/acpi?h=v6.9.7&id=2b2b0ac1533d790690d6d28899f01a2924d54d4d
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/acpi?h=v6.9.7&id=9750135f2f326879889ed60ccd68b96572dfa6ee
>>>
>>> i have build a test 6.9.9 kernel with these 2 reverted and 1. is confirmed to be fixed
>>> by reverting these 2 commits. Although the user does report an IRQ storm on the ACPI IRQ
>>> (IRQ 9) related to thunderbolt after this.
>>>
>>> I have not yet got confirmation that the second bug is also resolved by the commits.
>>
>> ... resolved by *reverting* the commits.
>>
>>> Either way it looks like we need to dig into this and figure out what is causing
>>> these EC related regressions.
> 
> Right, so I looked at the dmesg output in 2. and saw that the EC
> errors were reported right after enabling the EC for the first time in
> acpi_ec_dsdt_probe().
> 
> Because acpi_ec_dsdt_probe() passes true as the last argument to
> acpi_ec_setup(), it will evaluate _REG everywhere at this point, but
> previously it only evaluated _REG in the EC scope.
> 
> In the ECDT case, the _REG evaluation is deferred until the EC has
> been found in the namespace, so maybe that's the right time to
> evaluate EC opregions _REG in general.
> 
> So one thing to try may be to pass "false" to acpi_ec_setup() in
> acpi_ec_dsdt_probe().

That is a good idea. I have written the attached patch for this and done
a Fedora kernel test build with that patch added for the reporter of:

https://bugzilla.redhat.com/show_bug.cgi?id=2298938

To test.

Regards,

Hans


--------------IZCZo02FBIWBScZMNZdUm28D
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ACPI-EC-Delay-running-_REG-handlers-until-the-EC-acp.patch"
Content-Disposition: attachment;
 filename*0="0001-ACPI-EC-Delay-running-_REG-handlers-until-the-EC-acp.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlY2FlZDUyZDhlYWE2YTMwMmVkOGMyMTY1OThhNThjYTQ1ZjNjMTQ4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPgpEYXRlOiBUaHUsIDEgQXVnIDIwMjQgMTE6Mjc6NTQgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBBQ1BJOiBFQzogRGVsYXkgcnVubmluZyBfUkVHIGhhbmRsZXJzIHVudGlsIHRoZSBF
QwogYWNwaV9kZXZpY2UgaXMgZW51bWVyYXRlZAoKU2luY2UgY29tbWl0IDYwZmE2YWU2ZTZk
MCAoIkFDUEk6IEVDOiBJbnN0YWxsIGFkZHJlc3Mgc3BhY2UgaGFuZGxlciBhdAp0aGUgbmFt
ZXNwYWNlIHJvb3QiKSBvbiBzeXN0ZW1zIHdpdGhvdXQgYW4gRUNEVCBhbnkgRUMgX1JFRyBo
YW5kbGVycyBhcmUKbm93IHJ1biBhcyBzb29uIGFzIGFjcGlfZWNfZHNkdF9wcm9iZSgpIHJ1
bnMsIHdoZXJlIGFzIGJlZm9yZSBvbmx5CnRoZSBfUkVHIGhhbmRsZXIgdW5kZXIgdGhlIEVD
IGFjcGlfZGV2aWNlIHdhcyBydW4uCgpUaGlzIGlzIGNhdXNpbmcgRUMgcmVsYXRlZCBBQ1BJ
IGVycm9ycyBhbmQgdGhlcm1hbHpvbmUgaXNzdWVzIG9uIEFjZXIKQXNwaXJlIEVTMS01NzIg
bGFwdG9wczoKCmp1bCAxOSAxNzozMzo0MSBrZXJuZWw6IEFDUEk6IEVDOiBFQyBzdGFydGVk
Cmp1bCAxOSAxNzozMzo0MSBrZXJuZWw6IEFDUEk6IEVDOiBpbnRlcnJ1cHQgYmxvY2tlZApq
dWwgMTkgMTc6MzM6NDEga2VybmVsOiBBQ1BJIEVycm9yOiBBYm9ydGluZyBtZXRob2QgXF9T
Qi5QQ0kwLkxQQ0IuSF9FQy5FQ01EIGR1ZSB0byBwcmV2aW91cyBlcnJvciAoQUVfQU1MX0xP
T1BfVElNRU9VVCkgKDIwMjMwNjI4L3BzcGFyc2UtNTI5KQpqdWwgMTkgMTc6MzM6NDEga2Vy
bmVsOiBBQ1BJIEVycm9yOiBBYm9ydGluZyBtZXRob2QgXF9UWi5GTkNMIGR1ZSB0byBwcmV2
aW91cyBlcnJvciAoQUVfQU1MX0xPT1BfVElNRU9VVCkgKDIwMjMwNjI4L3BzcGFyc2UtNTI5
KQpqdWwgMTkgMTc6MzM6NDEga2VybmVsOiBBQ1BJIEVycm9yOiBBYm9ydGluZyBtZXRob2Qg
XF9UWi5GTjAwLl9PRkYgZHVlIHRvIHByZXZpb3VzIGVycm9yIChBRV9BTUxfTE9PUF9USU1F
T1VUKSAoMjAyMzA2MjgvcHNwYXJzZS01MjkpCmp1bCAxOSAxNzozMzo0MSBrZXJuZWw6IEFD
UEkgRXJyb3I6IEFib3J0aW5nIG1ldGhvZCBcX1NCLlBDSTAuTFBDQi5IX0VDLl9SRUcgZHVl
IHRvIHByZXZpb3VzIGVycm9yIChBRV9BTUxfTE9PUF9USU1FT1VUKSAoMjAyMzA2MjgvcHNw
YXJzZS01MjkpCmp1bCAxOSAxNzozMzo0MSBrZXJuZWw6IEFDUEk6IEVDOiBFQ19DTUQvRUNf
U0M9MHg2NiwgRUNfREFUQT0weDYyCmp1bCAxOSAxNzozMzo0MSBrZXJuZWw6IEFDUEk6IFxf
U0JfLlBDSTAuTFBDQi5FQzBfOiBCb290IERTRFQgRUMgdXNlZCB0byBoYW5kbGUgdHJhbnNh
Y3Rpb25zCmp1bCAxOSAxNzozMzo0MSBrZXJuZWw6IEFDUEk6IEludGVycHJldGVyIGVuYWJs
ZWQKCkZvciBFQ0RUIGRlY2xhcmVkIEVDcyB0aGUgY2FsbGluZyBvZiBfUkVHIGlzIGRlbGF5
ZWQgdGlsbCB0aGUgYWNwaV9kZXZpY2UKZm9yIHRoZSBFQyBnZXRzIGVudW1lcmF0ZWQgKHRp
bGwgYWNwaV9lY19hZGQoKSBpcyBjYWxsZWQpLiBNYWtlIHRoZSBwYXRoCmZvciBFQ3Mgd2hp
Y2ggYXJlIGRpc2NvdmVyZWQgZWFybHkgb24gdGhyb3VnaCB0aGUgRFNEVCBjb25zaXN0ZW50
IHdpdGggdGhpcwphbmQgYWxsIGFsc28gZGVsYXkgdGhlIGNhbGxpbmcgb2YgX1JFRyB0aWxs
IGFjcGlfZGV2aWNlIGVudW1lcmF0aW9uIHRpbWUKdGhlcmUuCgpUaGlzIGZpeGVzIHRoZSBt
ZW50aW9uZWQgQUNQSSBFQyBlcnJvcnMgYW5kIHRoZXJtYWx6b25lIGlzc3Vlcy4KCkZpeGVz
OiA2MGZhNmFlNmU2ZDAgKCJBQ1BJOiBFQzogSW5zdGFsbCBhZGRyZXNzIHNwYWNlIGhhbmRs
ZXIgYXQgdGhlIG5hbWVzcGFjZSByb290IikKQ2xvc2VzOiBodHRwczovL2J1Z3ppbGxhLnJl
ZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTIyOTg5MzgKU3VnZ2VzdGVkLWJ5OiBSYWZhZWwg
Si4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IEhhbnMgZGUg
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9hY3BpL2VjLmMgfCA3
ICsrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL2VjLmMgYi9kcml2ZXJzL2FjcGkvZWMu
YwppbmRleCAyOTllYzY1MzM4OGMuLjg5MjlmOTIxNWI3MCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9hY3BpL2VjLmMKKysrIGIvZHJpdmVycy9hY3BpL2VjLmMKQEAgLTE3ODgsMTMgKzE3ODgs
MTIgQEAgdm9pZCBfX2luaXQgYWNwaV9lY19kc2R0X3Byb2JlKHZvaWQpCiAJfQogCiAJLyoK
LQkgKiBXaGVuIHRoZSBEU0RUIEVDIGlzIGF2YWlsYWJsZSwgYWx3YXlzIHJlLWNvbmZpZ3Vy
ZSBib290IEVDIHRvCi0JICogaGF2ZSBfUkVHIGV2YWx1YXRlZC4gX1JFRyBjYW4gb25seSBi
ZSBldmFsdWF0ZWQgYWZ0ZXIgdGhlCi0JICogbmFtZXNwYWNlIGluaXRpYWxpemF0aW9uLgor
CSAqIERlbGF5IF9SRUcgZXZhbHVhdGlvbiB1bnRpbCB0aGUgRUMgaXMgZm91bmQgYnkgcmVn
dWxhciBBQ1BJIGRldmljZQorCSAqIGhpZXJhcmNoeSBwYXJzaW5nIGFuZCBhY3BpX2VjX2Fk
ZCgpIGlzIGNhbGxlZCBmb3IgdGhlIEVDLgogCSAqIEF0IHRoaXMgcG9pbnQsIHRoZSBHUEUg
aXMgbm90IGZ1bGx5IGluaXRpYWxpemVkLCBzbyBkbyBub3QgdG8KIAkgKiBoYW5kbGUgdGhl
IGV2ZW50cy4KIAkgKi8KLQlyZXQgPSBhY3BpX2VjX3NldHVwKGVjLCBOVUxMLCB0cnVlKTsK
KwlyZXQgPSBhY3BpX2VjX3NldHVwKGVjLCBOVUxMLCBmYWxzZSk7CiAJaWYgKHJldCkgewog
CQlhY3BpX2VjX2ZyZWUoZWMpOwogCQlyZXR1cm47Ci0tIAoyLjQ1LjIKCg==

--------------IZCZo02FBIWBScZMNZdUm28D--


