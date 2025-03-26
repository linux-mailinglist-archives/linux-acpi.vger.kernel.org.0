Return-Path: <linux-acpi+bounces-12458-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A112EA72048
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 21:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086373BA917
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 20:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F225E800;
	Wed, 26 Mar 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQg5n+Ht"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ABD1A2541;
	Wed, 26 Mar 2025 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743022677; cv=none; b=UgFOFcKBaStWwb/PjfGatxFfEIzVLWWoJWxHeJ64pG96dgaQG+TcDmlNKj7vEj5TiaevUDbJj5AaeNneZWeXsPkFnrxLG4pTGZ44+I4SXtmqpp1qB45KdQrwA+xiwmi3SuzzUozXT+/fIZBTto3fYv7jh6xEVTlo2iCLkrcxnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743022677; c=relaxed/simple;
	bh=Xv/Edr5Hb3rTIzpN5V6OcljHL4M6WZIYMoDXNiM7P5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5gwj/hOXM4MZoR+l0lGoio9JPfy0iZmNsZUI6hQyxvQzfldH+uPcVjYNTf5fFPZfrLxSHCZXSfy7S6eqezVsFvzmzwQ5CbPO4uoOdnkKYpAQVDRIzRykwQHGZJBMMDctT9FJqA1jSlB/06He8RNn9XDovx7bKQis0uDLPdtUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQg5n+Ht; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6003d977ab7so191515eaf.2;
        Wed, 26 Mar 2025 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743022675; x=1743627475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYHrkcoZFZa1vLsLrjHkrL3wMK0K9pCcIzH7DNM6+0c=;
        b=QQg5n+Ht7l3YHRZQ5MtJABwpBiOQqE4oiz05fAQXvpG+fAoEZ4K2/SSPNVTnSBNQAb
         HcjidJ3C5Zp3HEVUnP5dBicqdCyGt390A3VWSO7ZwNqIORAGRQqZP/Acelwo040n+wMI
         sKkH95xbj3IxgyboPlr4SdyfZ9Zg/M//4Smk7W1fpKT3WcGRQYj+o0kP/CCRBC4Og70G
         awEixFG3rojJqz6T6cMrkb28v4pJD/FMtlAEcmkQ+bPhb18LeExBn/xt0jOv/vlu1CJs
         YpMzdPOtWEiJoTZRi+s8LL5Rb1/ubQh4pWsQ4ydUjNXm+DeKKZDU0ioYODyVvTaYDIGa
         zWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743022675; x=1743627475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYHrkcoZFZa1vLsLrjHkrL3wMK0K9pCcIzH7DNM6+0c=;
        b=ZwrzbrVmCvQjy9lSenJHsRYUp59idA++YzF6JqRrscdYbkXr+5AQKYhuE9IFGAumVv
         CiDPErwnig4pQZQ3YRy1qOfOCQpTPZnTOJFI/q4hJYsnSVEVfrKtxzK/1bOKw+FqZa10
         Jqbe11IvyMqrWHzsdSrdXgNJTl6RqbJXqDSVDWSETjdSNhh8LQN64Y8v2q7q4hZhWTbH
         opCANLTIV7uY5CKlb7+5Xl7agkWWTqYqYqLS0CB6bUPW9JG7Bx0OClqcyP8OjMVZzRdN
         T79Z3EbQtHGQcOCnn5z+2c+wVVZ8rjZlfyuGwIWEr9ij+l+yN/eHl440vqv+u5F5n3c7
         yctQ==
X-Forwarded-Encrypted: i=1; AJvYcCWexXmkysn82QPBrSuLjGd9WGKg3zIK9xls6vO4B2ozHkZWpjtPd6OLXjvueD7GECagT4R2YYHr92LW8ROhLUU=@vger.kernel.org, AJvYcCXAzXvFhzFT8yY9qKZ58pwT7Bd+pKQ+3DAqscfv4CD2pyH2SZtC0F8Y6JZJIx0V6WlAgd7o9NHHZ9h/pg==@vger.kernel.org, AJvYcCXqNm1YfnaRDM2ZZYXdGA3XCDCLDLD4dFYvv0kcbfGBilCc9JDDNNorvX4SiCBgHBDeJSuuHGXlqpZEbKBz@vger.kernel.org, AJvYcCXuHNcfFSeEokC7rWrI1PBM7KwWGSqEw9OHPcg3MOVCh7mToZAq+YAEJhqj93uuCFWeSz1tqBQ0jaos@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8WFhCTL5Vgw9vVDTYfLF/BE6ELPkPGKhXwtgOJlfE3skW/1U
	I0MAlS+RFoYkr5hNjE5kux6nr/CHUp540U1N+daDniwHladFehS2
X-Gm-Gg: ASbGncsRzqovqDnbgxZAF2Yn/iaPMxMx5ydVwtX4CASEc97KvlACMjsF7lVuv3Y9eNh
	d/t52A1liCbrMuZn+6IUhvKLkmdlqPrqiCRI3DQRLS0cGmkTJJgPOSroG+h2uBey7NibnzO1IqT
	Au3b/NBUac5h/B1FqYHkMKcafiy9SnykoaAYA/Td6mxE9us9MyNn0wspB0wrGqJMrvtqK72FvmH
	+m8KXVGGdomWVn5xSwM0swciPZQ+yefzksZkqG6yo8Qxt5dsaNFL2WxUPGrOncfJgUs8/lWQSfI
	ib7g3c5Cd2VnFsXz+dp677LbEw/ZKr9tgZgJMDTvOC8v28R4WpbjJd4QYcPS7dJDWNFCaTN7oG7
	jmQVCsfUkLIeFtr/DBqgPpzF5aes=
X-Google-Smtp-Source: AGHT+IEUmSEVdaGxQzHRlalvt7gxWnlUq6R1qC4LIh6BmNt4i8VcMR3YrCDJk0WyRPA+5ibCH5mT3A==
X-Received: by 2002:a05:6871:7b0a:b0:2c1:5fe3:22eb with SMTP id 586e51a60fabf-2c847f73257mr612937fac.15.1743022674554;
        Wed, 26 Mar 2025 13:57:54 -0700 (PDT)
Received: from my-computer.lan (c-73-76-29-249.hsd1.tx.comcast.net. [73.76.29.249])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-2c77ec51be0sm3159443fac.16.2025.03.26.13.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 13:57:54 -0700 (PDT)
From: Andrew Ballance <andrewjballance@gmail.com>
To: remo@buenzli.dev
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	andriy.shevchenko@linux.intel.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	devicetree@vger.kernel.org,
	dirk.behme@de.bosch.com,
	djrscally@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	robh@kernel.org,
	rust-for-linux@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	saravanak@google.com,
	tmgross@umich.edu
Subject: Re: [PATCH 0/10] More Rust bindings for device property reads 
Date: Wed, 26 Mar 2025 15:54:09 -0500
Message-ID: <20250326205409.694744-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326171411.590681-1-remo@buenzli.dev>
References: <20250326171411.590681-1-remo@buenzli.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi thanks for sending these in.

On Wed, Mar 26, 2025 at 12:13 PM Remo Senekowitsch Wrote: 
> This is my first time posting to the mailing list, please let me know if
> I did anything wrong.

you probably will have to resubmit in the patch canonical format[1]

I would recomend reading the docs but in summary:
 - all of your patches should have the subsystem in the subject line.
 - patch 6 is missing a commit message
 - commit messages should be written in the imperitive tone
 - a couple of your commit messages give a reason for the changes but
   do not have a summary of the changes
 - for your v2 you should add a diffstat to your cover letter running
   `git format-patch --base=auto --cover-letter` does this automatically
   for you

Andrew


[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

