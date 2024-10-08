Return-Path: <linux-acpi+bounces-8598-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0048994079
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A2A1F26DD7
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC221FCC5A;
	Tue,  8 Oct 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kXVDyrNK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5031FCC55;
	Tue,  8 Oct 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371648; cv=none; b=KhHjYDdAeMsaSUVbAbs7HJArRgZ27QHcmNxedIyA5+mKaTfowPhk4zO1OBN8eu0xvBRYBV7M4WT4HXbLEWq3NaXvlyvLB1ibLVGO1DQIjNyKgnhJTDkEgVXSjtLxckgGkoVjwE3z8mIIVv8HrWOOQtJW/+41U1poc1HRZ+qAc10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371648; c=relaxed/simple;
	bh=CsqVV7FCFnCCc38K2TRxiXii5YTrPDW2heYK16W9kmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diHQST1gXDb0kWPnZC4HVFGdrJH0Db4Ia4zeKNj9FOxLlmOc77lhHlPSHm0HJ16xDOxB714mairf+GMA0ZT1po3LPi64sYIkDOSwTAlx+v6zs4EcGbZp8KCmVxQFq1PbU2tIXWFWKa6wYp9r2KBoKrBQtqVQPT/q+UlZkBIkX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kXVDyrNK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 022C320004;
	Tue,  8 Oct 2024 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728371644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsqVV7FCFnCCc38K2TRxiXii5YTrPDW2heYK16W9kmE=;
	b=kXVDyrNKQ56rC4pEv6m5/NjopeFfIoQ6Dyunw8W1vM/hCSv3FtLrpFQtR5iF7cvwQgubYZ
	m5pb6MUlVXq+yTYnfq1XK3x56/9LVtLOpIO5TfQfCX7YcottVCsP3dDK3lI8MVxfbcZeI7
	boM4Tv5EzDrl+qC8JY5/5KsLPEU7yQYLRItNb/otd4USEd2vz39yxPrBwjDEU46Zdt6bmx
	7/YEsSj9THPZuS26SNGqxdLsB1ywta03c3e4rzhMyZHaouyCDGpAn68PfqYQ7a3MmxJpmR
	jv+fTRjVuVHlac9l56vAnGXahxmUha8hEoSlnJl0ulbRHM2VNqOjDdW6Zoalkw==
Date: Tue, 8 Oct 2024 09:14:01 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Thomas =?UTF-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pali =?UTF-8?Q?Roh?=
 =?UTF-8?Q?=C3=A1r?= <pali@kernel.org>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 chrome-platform@lists.linux.dev
Subject: Re: [PATCH 7/8] power: supply: max77976_charger: register power
 supply with devm_power_supply_register()
Message-ID: <20241008091401.4bc3f0eb@booty>
In-Reply-To: <20241005-power-supply-no-wakeup-source-v1-7-1d62bf9bcb1d@weissschuh.net>
References: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
	<20241005-power-supply-no-wakeup-source-v1-7-1d62bf9bcb1d@weissschuh.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Thomas,

On Sat, 05 Oct 2024 12:05:09 +0200
Thomas Wei=C3=9Fschuh <linux@weissschuh.net> wrote:

> devm_power_supply_register_no_ws() is going to be removed.
> Switch to the general registration API.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

