Return-Path: <linux-acpi+bounces-15572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C402B1E14F
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Aug 2025 06:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D091172479
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Aug 2025 04:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2491DF97C;
	Fri,  8 Aug 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp8sg8CE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B81DF987;
	Fri,  8 Aug 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754627632; cv=none; b=asm97a5167BCmatxaT/TCsZMXDtj6jU0VU9f29y38RHuAPpzQH6RPVxBoU2pmCMTf1+MevdsMH4peAmXS6A5ohyqUkCrxs2qgWtpfhdYmXEUr11oC71vuzLwopbqFdhZ3BCGkYZnBppGd3Dpn757aHSO8uX1v0g36HCetw7MZm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754627632; c=relaxed/simple;
	bh=BUXbEIAcI0mgMCyhzs+8QJqtWeRRAW19GZvjYklvJ5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rvbwub9iUBmDK1m9ZRglxVrfcV0VbXwc+ufHHOToHsCpC1BiJNJ+qCMR2FIzwvTfFLYJkf0XyMi3oWwLUrZBT+a6Mz8up3ShKNkGCbvtK0qKs7/XBXwuc1kiiIuReN+85/F5l7z/y1NwyIyHR9+bY4RlXbktzCw8BrTOBIihvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp8sg8CE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-741c0d47aadso1186879a34.3;
        Thu, 07 Aug 2025 21:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754627629; x=1755232429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUXbEIAcI0mgMCyhzs+8QJqtWeRRAW19GZvjYklvJ5g=;
        b=mp8sg8CEpofmevv6kDdo4hnCg+I7xopsd8rRcjY85Ct1EYEZ60v9YX6k6mlaE1CM8O
         RHtnmJC7J7rzK75K8uYiSXRzoO4StCQEUFvfZuCxwbVeoMcEdVk9zOk6m0lst6jr0cxY
         uw8aelCogeu4vrUve36T6vwxqzsDTAvL3vES/buO8w+83HgQTEJHYEAMC77pRxi8eNNn
         SXf4ycA/RO8s9wC6i2zPzPWnJmW/iGM+JUTHD65oMAy8yF6Y/hn2bs68vGKh+JG0HGPr
         f5WoWUIeL1v5vJvrX8IL8WdvK6QFc/9i1HHSO8o1sAYPCSSodPcIXcjmt5qf81UtWva/
         s04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754627629; x=1755232429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUXbEIAcI0mgMCyhzs+8QJqtWeRRAW19GZvjYklvJ5g=;
        b=SXzTz0KGDIElsHGgzv7SmZTvCS9/LthMpc9q/6v1HBHWbDB5WzRgdCg0aqW+6WmMVj
         P6JRD8/HLoqS7pcp1jVgwOp2lJG1xea+wXr+nRycfVk9Wu2amA1+4UhU6wpG9PR+36FJ
         DUvQdd0vxBR67PBIGunh2SeHoi1KiSo9JUog0c6FhfBtRcbgY8PDpgiAuWppvG5z0Hoa
         xiFaF7MwLnYcvbMbyDBOyJ79scLrAIntr1jbtJeVj7W8HEVITVX/eeG8aLdLdVUHx5XH
         JzE4LmqQHmDjP0NNfryuEHFHG604zsngafZK3Thfjak8z26cSSPnBQDiTQTR9TQWTesZ
         NhVA==
X-Forwarded-Encrypted: i=1; AJvYcCUIWtiy4xSkLVoRIwVAj5tq06WV6/HI486oESkAOXL9tyEHdLJpd85eKCXgrBYlOWWo/f+OWgdi@vger.kernel.org, AJvYcCWft5fP6XKzGkkLtT3VtDZmFLZ3PpA00bWdcd4x2ebcPEtswcFrlMYjDXosMRNlH1Kl7XFlZwcbIJJs@vger.kernel.org, AJvYcCX0qHK83mLreKhsviFXw1RC+eCOwu2POzYeN1jb7bindfoW0WHj/ASzsWAobyL7mwsj9mrB/aFS2lQrWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YziSfiEbCiYGx2JgsTCzQbJ5McPDtACupGbvad7GfWK/ekA9Tni
	3FBKStmNGA03V944aK21vfa3CPd8ZaWAw3EQMOYYbGbYQreTEU2Ujwcc3iOmYRR0/sb1oznykiR
	1HanR4c71BjZ9UfYJVj/M+F6NSXxjk3E=
X-Gm-Gg: ASbGnctpZLqR6PaLzNaq6JJnvBXEl7xNx52YxXJJ3wizmtiuWFRDcuAPgV+1uD84REx
	LwCoHBcZ13ZCFmDfqdDR+Fg/Id+4XbXvJ+h+FwHVF8B8VsiBf50RScENQt7XOXfZ+4loR7n4Jy5
	03AgRKip4XWyOa46Ijt/2rgwk5X0a9iT/Y5PLs2vbRjuguanpXwwGCnUmVsTQBdc75OuJMWRN1F
	ZZ0R+qu
X-Google-Smtp-Source: AGHT+IGO8tBbLeDZJoOjPhjnLk7dam86S6oTeXOoWzdDRYSZMgXG6O6c64oJbVKVE5zxCVpAe/NGfGE9LIIMJrKGh/M=
X-Received: by 2002:a05:6808:bc9:b0:435:6bfe:255e with SMTP id
 5614622812f47-43597db9825mr814500b6e.29.1754627628938; Thu, 07 Aug 2025
 21:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804121453.75525-1-zhen.ni@easystack.cn> <20250805034829.168187-1-zhen.ni@easystack.cn>
 <88a0618f-121f-4752-ad65-e9724403cc16@amd.com>
In-Reply-To: <88a0618f-121f-4752-ad65-e9724403cc16@amd.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 7 Aug 2025 23:33:37 -0500
X-Gm-Features: Ac12FXxq6MvWRflUTXQgkW7F5goFhJhZMp3Bgggac3m1ChGNnCIYgBjrDzjC70E
Message-ID: <CABb+yY3o0v_g=0+A82+9b+jS20fusnw3up7gS7_Z910CDKM=4A@mail.gmail.com>
Subject: Re: [PATCH v4] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
To: "Aithal, Srikanth" <sraithal@amd.com>
Cc: Zhen Ni <zhen.ni@easystack.cn>, Markus.Elfring@web.de, sudeep.holla@arm.com, 
	linux-acpi@vger.kernel.org, stable@vger.kernel.org, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 8:40=E2=80=AFAM Aithal, Srikanth <sraithal@amd.com> =
wrote:
>
> Hello,
>
> This commit, now part of next-20250807[1], is causing kernel boot crash
> on AMD EPYC Milan platform.
>
> commit c3f772c384c8ec0796a73c80f89a31ff862c1295 (HEAD)
> Author: Zhen Ni <zhen.ni@easystack.cn>

Zhen, while it looked reasonable to have a corresponding
acpi_put_table() , I also see the documentation of acpi_get_table()
talks about early vs late stage calls.
I don't know enough about it to be sure that doesn't apply here. So I
am going to drop the patch until it gets reviewed by acpi/pcc folks.

Thanks,
Jassi

