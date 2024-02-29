Return-Path: <linux-acpi+bounces-4016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716E86CB09
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Feb 2024 15:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC841C20ABD
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Feb 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7830012F5AA;
	Thu, 29 Feb 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qW2PHaIm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB912F38D
	for <linux-acpi@vger.kernel.org>; Thu, 29 Feb 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215935; cv=none; b=ZOQP5fLQnHXBTgaKAArpzJPgBsJ6ZzoohW3sTa/HT8gbFQo6KO57SbeFNs7RVYoMJxnTE6750viTevg8aQ7Yl1KQATDA6O/L/4bq08QqY6IZdOVejAzquVjvoR3LPKKge7EGm7Z8KFGxfqDr2VuoUKro0E3X0M7z+GwzZIOE8yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215935; c=relaxed/simple;
	bh=CvLDc1XcjbF1F7NzLO6PHxnaCxyOqxfcXll9ig8clKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdksF1M/gCMzALnNvmP7EjHNSdQ/2RmydFP0UpBPokeNioEWvbegwhG0OccTFGWAj9c+l30r9RWfzO2du22SaK0L55tKKLiUMIU3WIVb9/kzHjYcDpKjjq5Lf7iVD+4bTfvTVznnIrymOqJgj+Qre/u9/zP3EQauZnZL3luRD2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qW2PHaIm; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso923389276.0
        for <linux-acpi@vger.kernel.org>; Thu, 29 Feb 2024 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709215932; x=1709820732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvLDc1XcjbF1F7NzLO6PHxnaCxyOqxfcXll9ig8clKk=;
        b=qW2PHaImxY/wGo6lfdvj0bTPJgkNFtmtma/qM6KM13lmeB/FICw+aOa0VYFj5uld0D
         YR+WduKxVfpGYJrLn8iVjd9rO1fuph4a67wqaFh9fSQFxy3Mywn55EEsFTl3uTMfQ1EA
         mnLF59f8BdO7JHeffXyyGIX+QSAzFeDi00mcL2Zsz8ik/Bb04BzfkhVRSY0HGb6cNKoj
         5uXo7FPYuvOgwiM4eO22urHkhY/T3b6WPZ6ThbL+n0p4z0sk5hXTmPm8ODvZb3GmU3La
         1Gns0To+tia5rH5VsBykkwd9+lxodD3zuxLvpZk9qClH6HXyHyZKfnf+m7mmnKhfMFX1
         9TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709215932; x=1709820732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvLDc1XcjbF1F7NzLO6PHxnaCxyOqxfcXll9ig8clKk=;
        b=DTxkkf31tEcdkn+cY27ItJYfSE6+NEGllomA/O5o2fMMvGmFmmDtDfyKLEZXE8PRSY
         dt9HixQnWQpGIv99KxqCosnUM/ya+sY1IZpO6jz1QcLedKqS6Qj6ZqRDgHNilESee2jp
         atbS8QS6lczQlsNDEuyDaZFBgGyQFT10pik1T22j9OoMDlyd8xiTSVwJawH3s1XI7k4i
         lE7M8TJa3Tib3LT8AmfwNDfBRqspx2YHrRSFrQyHNAcO4IhdZTIup1ER3pHh206Q3YXa
         PRwmhfJk1yBCwCaMSLH80BTRREb1hG/DU25qBD7UEuEplqjc9qvdXH/PCe0ZhOFQvEVZ
         Hwvg==
X-Forwarded-Encrypted: i=1; AJvYcCUpundLq+BKKRboPQenuN81bV76q/sQ1H1WyVvk4LV5EDNcYs/BRop2MengvvhcB64UgrKATmZ6h/gbB4Eq+9wzTZAaBbPZbf6/Zw==
X-Gm-Message-State: AOJu0YzAfJ+BVdSd2rO82liZnNjg7EYYIvkyftlK/9NYXteBoPUPaSqT
	dQyWZ4NO0XPDMIV09HMKQPRL+q4PfO0OoL/5+EJ4ncYpM39MymNyUM7R/iqs6/Ku5oixdBZcJKu
	nKOfDgZpmDnCzDO1nTgvknq2F6QAqcTzdB5YIq41bV8AJnKqA
X-Google-Smtp-Source: AGHT+IHxnZN7aHNIGYMA311zt+7uvT7fk6b9fb24xADoJn/BmejCf0pjyDbjm52YexRoGE+uFY9V6BUytI28dnMCTLY=
X-Received: by 2002:a25:890f:0:b0:dcc:7c0f:2222 with SMTP id
 e15-20020a25890f000000b00dcc7c0f2222mr2458086ybl.22.1709215932355; Thu, 29
 Feb 2024 06:12:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240228184412.3591847-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 29 Feb 2024 15:12:00 +0100
Message-ID: <CACRpkdZPx4vyq8bHbQj_CbyrMprbdsLgCbW+T+c6vGPqFDJmdQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] gpiolib: Align prototypes of *gpio_count() APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 7:44=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Two out of three GPIO count APIs take device pointer. OF case clearly
> does not need it as it immediately switches to device node inside, and
> ACPI abstracts that to struct acpi_device pointer. Unify all these by
> making them to take struct fwnode_handle pointer. This, in particular,
> will allow to create fwnode_gpio_count() API if needed. The need of that
> was discussed here [1].

This looks reasonable to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

