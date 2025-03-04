Return-Path: <linux-acpi+bounces-11753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02581A4D6DE
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 09:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8247A37FE
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBD31FC10F;
	Tue,  4 Mar 2025 08:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IpNCNxz5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973FC1FC108
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077906; cv=none; b=Y/IZGLBcwWGFMAIPFpfqwvQgZW8DXiNdrgsx1Um4AByzc+4HhkDAZz83Cxtm238e4E9vg1hKKYrjHA1d4NTLXF/430VgYkh/8IVZp0vy9PXs/UjDQzwFGzay9WPHIj/oYxrtuEvjfzyDbdNYpWMY1osZSvpompVpL7UDMDPdEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077906; c=relaxed/simple;
	bh=pR+bRfGQlzWx7gBjcdSucJAnN3K9ea1LhqswU3jkQrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLWik8WJA/1IupE+tF1sWomtOU5wicj/OvIyIREsv4B4s6316uMQqUyIxSZJdkamQxhu6iT88oOTur4uWn+2YTWm/QU2OFIflIqslGW1AxnCJpH8QSuVuRsgo7rrwGAsybS6F5KjTbtxaESma7Zinv7Xbb8MfgPDLM1of5q/eMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IpNCNxz5; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3072f8dc069so58183821fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2025 00:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741077902; x=1741682702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pR+bRfGQlzWx7gBjcdSucJAnN3K9ea1LhqswU3jkQrg=;
        b=IpNCNxz5DWjg1NDjK+v9sQWobdNY0C7VexzWIoUdOBkB1jFTE7ulKywoIiL2dOlQil
         uMI0qxKIqgLP6VrX8//TPapY41dzYjzkd9gQ4rMCjMVP85q2mH8z6877+AhpkEnJDDgb
         TZlA29t2oloimwJNjngCRPWYQXzpSBCNs7nlbDtLYPqa42OUYDi3t7SPidoVXG46KTch
         Qqk9WkXgv0WOh9R9yGcQd6J89IdvYMHd3SqZmj3owU8RFGRQku5/V5mn/KWdXWhFXTxo
         giRGuE60LvK5+rxuMlhjroZKiIF8/LIRvTbWY95ROtvhGZPRRoHIVE/397F23lFlAOwT
         6Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077902; x=1741682702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pR+bRfGQlzWx7gBjcdSucJAnN3K9ea1LhqswU3jkQrg=;
        b=WyI0OExohirT9kJ3gLygMatIXDlwmWOKsx8Os9Ax4fKrTR9CxhxitntizdU78++6Y7
         J/McLzdCIF+PbR2Vza66BhBQ10zzOBuCPaNCPyOkqMwGyQExjW7DQ115YGaQcREP+6An
         pbPGcSKZMlpZbkSKuwNBsSw38ySEZnAFlXI9wbEoQU/RcHzbnmELHbC8Af0NDAeZBMCO
         o2CKqzLL2BG+R+8fkeemTYMjohg+l2GVY5+sr0PEN7iJriTuXECPZP+BGBVEoRSpzLb/
         JQJiloXsfHHnXT6mQ+Udy7fRlChSJC/cPckCDwXKv9Kc/FsLlLzY+ONPAyURZCSY59pu
         zzKA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kyd8CX8GNHfeiqXLrNig3stDQ/EgUJFWvbERxGa84PmQMqYYDYJt52DQ/VX67YagvJ08wIE95qWJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs+N+cG3LV6tbuXIHSR8ESWnshvhli+nF26iIstUf5JKiVLi5I
	pTF2wTlacYb3D7IYVWJQzeAfqt4dQCkyWTDMYcp5fLXPUPUK2Myus/BaAWbVh84YJklCOOu2OpJ
	XMWSVroYy+dC+mBHsz8UVMYfTxGNJ7gumTY6rDQ==
X-Gm-Gg: ASbGncvnCndVlKxFlf9TcVqxHuWva19eI4MI4XI8xjXrb60mMfaWv/FqigHyz0oQgRR
	dyeR5qTghr67jN9fOXCAOdb/hoLVAnutdg1/cZq7dxBygiYGpV2At4Gd2d3eXHSQncL1keFlA3L
	Cvq82DtjlQ1stYjgC7yK/21k7W4A==
X-Google-Smtp-Source: AGHT+IGgRiH2oS22RGfJxg7aIwVmCJWTNc+/r77/fuTgsqtE4Ux8/GK0e63mEvBxg75vsi2ow2K3BDFTL4IZbFj8pc8=
X-Received: by 2002:a05:651c:1546:b0:30b:d35c:4754 with SMTP id
 38308e7fff4ca-30bd35c5025mr120331fa.10.1741077901727; Tue, 04 Mar 2025
 00:45:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303160341.1322640-1-andriy.shevchenko@linux.intel.com> <20250303160341.1322640-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250303160341.1322640-2-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:44:50 +0100
X-Gm-Features: AQ5f1JpGA_-UhNoTPJmPBEBi7eNV4b_GKZenv7aPR3Dmi6S0SC42FWEfJP36qBc
Message-ID: <CACRpkdZ3E9J3+P3ANK-+NDidnsoZG-8UWP_G98Oai-dp6fk6Xw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: Align FLAG_* definitions in the struct gpio_desc
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <westeri@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Align FLAG_* definitions in the struct gpio_desc for better readability.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

