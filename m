Return-Path: <linux-acpi+bounces-6021-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589CD8D1512
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B591C21431
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6696F08E;
	Tue, 28 May 2024 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLvZxd2I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF673443;
	Tue, 28 May 2024 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880390; cv=none; b=gsj7bKWjyS2YlYbOMzap8sp08VW+rd+GeAJFP2WOZf+tvABA9dWjK7LKYfSuXZySzJ76L78xbSz9s2/RkwsRVjsBS6SUQxm3hdlxtBXZhRfNhxJSOoIvZQfkjMzdPIMTwe3mZ9k5cVGl1vb9jjjSu6rP3v6wJ4c6i/TmVJIcDAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880390; c=relaxed/simple;
	bh=UfhkQVosL+oCl3pxeQc9cyceNU12bsBq4sjRhs/0oQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tg03lEsDn1BuirELl3WFh+heGdif5ZPQdrDNlCdee1qgGvh1q97RvmI+MUcQl9RxheVWosWrTQAyeIzPeHT56ZvwWIoE+w/ocEYy5BVwZPFOlSFFwz1D5VDb3KL2P+rQjA/kLlyHJBEwLgLtPW3ndNs7xiMIXA+mJ9bDYD9MKaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLvZxd2I; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so5846061fa.3;
        Tue, 28 May 2024 00:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716880387; x=1717485187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbN8iFA5Vjgo5SuU7PH7u5E08M2Kd/8qmR0Aaqp8vOI=;
        b=BLvZxd2Ict4bsk5jxWWfFatoXikJ5LkD5bhwdwPPr1lvZM0e5zG6LwYt/YcS3khS6K
         Z5KgYztmW4Evks5YVTm4thvelUIK8HpyNqUNqHaH5wMGKW82CdcgfWgOg4p4M/mktpPz
         EZmYozcvyJBxvHNLsx9gSQuRCJTR0QSiG4ijqBLSf6JjpMPXqZiqRyHnsxqadA+q2PXw
         two0khgzhnwMnRec1Bx1M70EiNvuECyqaEHALan3FsgZIo2+9YRJ8tnwp5PWf1+ANgPh
         C4d9lYfhLN8NAbwhzfecYbGR6+iI81GMO58H89y4ccS50DnBRYIRqoMsDqfZWuWGxWAG
         adCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716880387; x=1717485187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbN8iFA5Vjgo5SuU7PH7u5E08M2Kd/8qmR0Aaqp8vOI=;
        b=hlf3XXP7/LgmKCgqPE+94qCO77IXz8oCvaFQhIFsJ9WVAbXjsM7Llg9cWuhLkFIjaO
         cl6k0enLXQGvlm6DZzI/61EtCwHa2zTa1QKL+HC+HlvF6wF3lYma91H84uWy2hh+DLax
         NBbcMWABSvojWkoUeUHeT5nASxwgF8Swm0QsUPQ1JgoqZ1UmOeAT2G9w0t4AQZM8i0GT
         ByvhWUzkmXO0IxuFj5vaG+a+0AjtrHmMWJEbza03WlwDjkBHS7L5V2hx4QcwG3urIRte
         bhq/ZVclesYQDR/nDmu9uD5H7jRGmr7bvXZzmkpDVcFC1jeUYKHGMnjp1B8MV/BfxpOC
         Zt7A==
X-Forwarded-Encrypted: i=1; AJvYcCVvnTvxDhBXnwMm8+KolRkiPFqyBYtUglK4DsrB7ECg+hjwZ++g+reQWc1WA7u4mfHqxcfTJYT8ST0vmaWy5c5rk7ymF/q9nNG6hfgSRT4LzKWT/UErWI+JiIpWH2xdrCIj+B+J88NbZA==
X-Gm-Message-State: AOJu0YzEl3pCIUL+Tnf1lGLn2ClO9j90K8iGAMqYiJtKSRWz8gtTGP7f
	uOnP1xepxkFnuz2Bn5RxVvb8V1/iyHF3LODds5wTsFtstpxprcoOxfN0IG3pg4uV5NY7Hq9E3zO
	uLICxm603eDSb09TYacwLuFTLHPs=
X-Google-Smtp-Source: AGHT+IFmtTX4poS64Oy5QVA1TRp3+Ayt3egLX2L31ik5nXCN4bjC/nAgnDwJx65RWXovKVj1vqFrVx99XSpwpXNn9TY=
X-Received: by 2002:a2e:a403:0:b0:2e9:8852:3d16 with SMTP id
 38308e7fff4ca-2e9885242f1mr5984361fa.35.1716880387386; Tue, 28 May 2024
 00:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com> <ZlVkgf_XCZcZd388@infradead.org>
In-Reply-To: <ZlVkgf_XCZcZd388@infradead.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 28 May 2024 10:12:31 +0300
Message-ID: <CAHp75VftLmV5T9xRnirOMXbJoyvm2eUiG4bDeB6p6hY6jExFQQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guanbing Huang <albanhuang@outlook.com>, 
	Guanbing Huang <albanhuang@tencent.com>, Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 7:58=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, May 27, 2024 at 11:24:24PM +0300, Andy Shevchenko wrote:
> > Since we have dev_is_pnp() macro that utilises the address of pnp_bus_t=
ype
> > variable, the users, which can be compiled as modules, will be failed t=
o
> > build. Export the variable to the modules to prevent build breakage.
>
> NAK.  Please move dev_is_pnp out of line and export it (as
> EXPORT_SYMBOL_GPL), please.  bus types should be private unless we have
> really good reasons for them not to be private.

FWIW, it's not private, it's just not exported to the modules. Are you
suggesting to hide the bus type completely to make it static? If so,
this is out of scope of this fix.

--=20
With Best Regards,
Andy Shevchenko

