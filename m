Return-Path: <linux-acpi+bounces-10197-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE89F8330
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 19:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68067A1918
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3FB19E985;
	Thu, 19 Dec 2024 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.com header.i=gazo11@mail.com header.b="K6KNvsfV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.com (mout.gmx.com [74.208.4.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C318E199234;
	Thu, 19 Dec 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632581; cv=none; b=Ul/SLwnCG9peav5gXrXdbnJqzIMMmqc5Ty3e0BZis4wKW5ULFQwjDPh9s2nhJRvd8C75u/rHpaTamzGmRLQpblLDPiBrn5Qwl7FT5ndrjstPH0Hm2BwI3d3hadYKLcUi+zJgX79z29+RueC8v9susQgLCNwMtpKJJwlobz+6qIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632581; c=relaxed/simple;
	bh=s5JlFHZHj/SkXwPq1A/1ZNcSzrC1Jf41gd9ygI0gvsE=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=VURKbdUGLY6IklcImHul/FYBpW+6O5y65Ubb6Skol1nowPSZQr/5E1UYHFA5m7G3qDHJrgX+uov8TmMq3jiYLcE3n7wGp3jCCe6r5pJWFrghQFCkfxc0lDboL8R7heDjYxGIFpIL4064kSBHHnFq6VnF6jLstjk7oFdSRF/CxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com; spf=pass smtp.mailfrom=mail.com; dkim=pass (2048-bit key) header.d=mail.com header.i=gazo11@mail.com header.b=K6KNvsfV; arc=none smtp.client-ip=74.208.4.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.com;
	s=s1089575; t=1734632564; x=1735237364; i=gazo11@mail.com;
	bh=s5JlFHZHj/SkXwPq1A/1ZNcSzrC1Jf41gd9ygI0gvsE=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
	 from:message-id:mime-version:reply-to:subject:to;
	b=K6KNvsfVlrWJlIKcjIQltL0/9eFTCPIitJZExwIv9xYwdac6UpTarwkIwO+CnB0w
	 m3g0SQ12Gp9l5mT5jRJuBk5Ct9v4eQl5GgRrPpV2CeeHEiJf1NKttRKgndwoJdRQW
	 XIdLVWDDe/WHh9bwJqtSCey8aH+aSdRcv5q6FjXIYa4SUpozXDbYJe+f4GN+niwgD
	 +0cQQDP6p8eRO8oj2gt6TSeutfySh6kix9afxF/wxmFGRhASaVBHsFvybx7dx1ybe
	 5D5Ye0kIaXDDS70OZyOH3CF4iIIPJVX+aJof4vxl0W1QUmxU9OBZib3cugQwPNo8m
	 yeD7oYmEb4XWqb3MPA==
X-UI-Sender-Class: f2cb72be-343f-493d-8ec3-b1efb8d6185a
Received: from [77.137.74.199] ([77.137.74.199]) by web-mail.mail.com
 (3c-app-mailcom-lxa11.server.lan [10.76.45.12]) (via HTTP); Thu, 19 Dec
 2024 19:22:44 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-cd6b8598-763e-43fb-9ae8-2b19ddd7f56c-1734632564710@3c-app-mailcom-lxa11>
From: Gustavo Azor <gazo11@mail.com>
To: rafael@kernel.org, hdegoede@redhat.com, pmenzel@molgen.mpg.de,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org, tamim@fusetak.com
Subject: Patch 3/4 ACPI resource.c.Add Asus Vivobook X1504VAP
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 19:22:44 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:iNOAmffiJBTVq6wMK75SNwXPXglY1SnBZNe5oouvPDgM+Ppy2cLDYIvkodkh3q5kzopVh
 wlc8XHermQ6OLLu5vujibzWlh2N2K0QSiW5XBW1ei1OQMDjZKIF3kp9tfZ+1cpRJvRk4f7ArNdY6
 uVKLS9Q7jlSnb3bT//j7TqANRFWvLjBrk8vvwQg5v3aFyxpMJHwmkDIr1Q2S+KU8k8l9AKTdhoYx
 IOfkTkwlawB94U5ctSNNGAo7mSJmSJoDj7TzQv9mChj7XNQQnzXhoxNizVA3ygtoONIya18QOK64
 us=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:O0uWNkUBrrc=;Qiy9BRVIALMygfDHfob9y0SqYlk
 G/DKrtb1p4ldlSdv0xeRmcfoNGV2EydRX3gogYz56o0UEsUeOo9y8m0ZrpH9Y91JmhgK3Of2y
 ePztGd7rQTUW9Si/Y++NIUF6KoizsNZfEGeqXo9NueGrWZppk9GuZ/IoJTNlxIYz1eS/2yrGS
 UE5HJjLEurjbzeNSC4fJSObpzUm55tG8uAuvDBoK+EVxEfLe3FWsh/TUaZcI56Mq3TFChFY/L
 AlFiToOPSyj6TkqveWVvUGX27B7PIOnSIEp0m16qReppie9lLftIPVEXto1iT8ftb2+RIrcY0
 vEkZOxIqfJv7UG4h1gRFktdf7jy5aj5xdV3qIZM+OiIpQZFmK13rCS6stE/ZchcwnvpCR+ju9
 SM90YyUX21rOn0E22oQyxIqa7X7Npb5/OfXg6j+4nN6RAn0vM7zuphbDb31a+JThnqLi1L27T
 obiTS/lcTUr7b+/2A7gNiG5uAnT30Ubqv0e6a4Hrpvkw1O2hNMhHm5DCJ9Nspj/CRY5HyHZGF
 25ayX8ldx+jMdK99L6ZIAijCcz5QBVx7PUBmEv3B6Bs7uBTa2cL9qc11gal7lgpP1GNY4N1qr
 5QCJkUbNwfe/xADpUrj/9i9JQrC2RR1tM12odX646CHUxMD21kXNtG16u5TKPvIZXi2JFO5LD
 Gx1JmLlwbGDhpLq1GAu07nuwMpMjpiPYd9tN/I8pkOUFHT9kK4h4oBG05Q8E0RyJIJnQrRftE
 x1IZdPf7BcSVVVOIDF0Mm6Xo87epUHk5hHSwllxd8NA7f+oMSk7W0Ae0kt+TXlOGqPNOYb68J
 auENW/iW3/Fv0YtNQfK9QLoAQSc8pwfdqgLzWlr+d/yhOjfZX/gN++nRR73Hx/3xDow8JwMB/
 DtLMKCEcX5jIuWBeqOXfGncS1lW8+UEYkNCs=

Like other Asus Vivobook models the X1504VAP has its keybopard IRQ (1)
described as ActiveLow in the DSDT, which the kernel overrides to EdgeHigh
which breaks the keyboard.

Add the X1504VAP to the irq1_level_low_skip_override[] quirk table to fix
this.
Thank You.


