Return-Path: <linux-acpi+bounces-14579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371B7AE745D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 03:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC0E179127
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120FA15A86B;
	Wed, 25 Jun 2025 01:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amountary.cfd header.i=@amountary.cfd header.b="LQu6XONi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from amountary.cfd (ip44.ip-51-81-76.us [51.81.76.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739F86338
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.76.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750815810; cv=none; b=CxXTDge4GIFFO5fVvGQEPd0gqNqIAQO9uxugCpLvI9+TIuoEtDOha5UcPKb50vrVxQ++CJ93N9HYsh9pdkc9iTaU0t9zymZSuNLSxghF6+DXgylAaftorSI+lkoPDAwPzwcnxv3B8LY7djyZaQvi+bXvuQSCWqoz1ZRKiuF0oCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750815810; c=relaxed/simple;
	bh=ystuPIb1z04584X5UNuypsWSat3RuK32bgjCEidIwVs=;
	h=To:Subject:Date:From:Message-ID:MIME-Version:Content-Type; b=FNU6qKNGya2aoOCRLY1RAP+kfGYJTN/LZSXICFI5t4OzHesXY2dCaYvW/+0HeA3ztvrPZH10Qm4LXX1/011Rsakmw5pylaJGySPG+D3Uz7POpAGr4VlUAsiieZkNM4jAHo8dQyTnIbOUEdTFctgaVLGHyh46LBt7ehuLahs2nh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amountary.cfd; spf=pass smtp.mailfrom=amountary.cfd; dkim=pass (1024-bit key) header.d=amountary.cfd header.i=@amountary.cfd header.b=LQu6XONi; arc=none smtp.client-ip=51.81.76.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amountary.cfd
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amountary.cfd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=amountary.cfd; s=mail; h=Content-Type:MIME-Version:Message-ID:Reply-To:From
	:Date:Subject:To:Sender:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hduerycFrMHHmX7f0S56SdU5S5R+b6DZqD3AeW+URV0=; b=LQu6XONi+s5DDF/tkT7+kRmFlR
	8Njfb4RINVEXNpzpd+fWLv2+m2h/chRZBEbCe5vBGZVQvOg7LPI3xDWaY0aC4KqiXOMUCpG9PjWGG
	5FIHAaAB1djr1t9yC1tm2yBIlZTgBlffnZSXtXKXhUYtfrD6CRCQ0nWbe2T8kT2nQNxo=;
Received: from admin by amountary.cfd with local (Exim 4.90_1)
	(envelope-from <support@amountary.cfd>)
	id 1uUFAY-000TqP-Rk
	for linux-acpi@vger.kernel.org; Wed, 25 Jun 2025 08:43:22 +0700
To: linux-acpi@vger.kernel.org
Subject: For sale
Date: Wed, 25 Jun 2025 01:43:22 +0000
From: Exceptional One PC <support@amountary.cfd>
Reply-To: info@exceptionalonepc.com
Message-ID: <877197683b9b72e69b6b4c53a1c156b1@amountary.cfd>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

WTS: 
Intel Xeon E5-2683 V4 SR2JT  2.10GHz
Intel Xeon E5-2676 V3 SR1Y5 2.4GHz
Intel Xeon E5-2680 V3 SR1XP 2.50GHz
Intel Xeon E5-2673 V3 SR1Y3 2.4GHz
Intel Xeon E5-2696 V3 SR1XK 2.30GHz 




SK Hynix 48GB 2RX8 PC5 56008 REO_1010-XT
PH HMCGY8MG8RB227N AA
QTY 239 $50 EACH


SAMSUNG 64GB 4DRX4 PC4-2666V-LD2-12-MAO
M386A8K40BM2-CTD60 S
QTY 320 $42 each


005052112 _ 7.68TB HDD -$200 PER w/ caddies refurbished
Quantity 76, price $100

Available in stock. Clean Pulls Grade



Charles Lawson
Exceptional One PC
3645 Central Ave, Riverside
CA 92506, United States
www.exceptionalonepc.com
info@exceptionalonepc.com
Office: (951)-556-3104


