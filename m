Return-Path: <linux-acpi+bounces-12570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E57A76CB1
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 19:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C529B3AA709
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 17:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDD215777;
	Mon, 31 Mar 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUuqOTJl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068D42144CD;
	Mon, 31 Mar 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743443715; cv=none; b=H5PxkMuKMhXq3SnQR49uBTSIskxI46nNpRsepUzXKbjmS3Z5e36LUcxPo7INg4S8caNMewDUtfdH5sYeJSfWxUPNKp0AT6iyx7p+nyA6YFfP47N8OkE8ApSFk3yRVXYaFo+7tL+JR+0AOJl9mU/HuVmeOAsEFa2tNYoDTiAagJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743443715; c=relaxed/simple;
	bh=ttvXahU6JXAuXxoEGpK31TnHIITuNAysaxcF/tKm/NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxo2AVvZ5r3a2UgHrMbD/jAsfD7Mgzp+ZIEgDl0JUvaF0cFiUzBdwF/eQtSV1JqYzs2da4XJFzxvl1o7rY/yiq9+u21bLnz9FnjV93NgRbFPRupzy34K4Iv+/fXJNaJ4OxkaTKc3hGtdp75BJegbzryMLXldo8hTAEB88ysx8k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUuqOTJl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so7084388a12.3;
        Mon, 31 Mar 2025 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743443712; x=1744048512; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KXTV0VWzIghH7eWjopMb8VSJWH0nbYt3yb1dFJgZQTg=;
        b=dUuqOTJl6naDXqKZCf+67VGk97hNfoOtJ1Rg5vvjoA8CQvM4YOevNfu0MNjDBz3R2w
         PXXRmMY/dNuB6IpxFVjEaVYiNiPXyfCydh+1BhLJcLQPiRgMQBCV0CtlFrSgTHx2/h3z
         Q/pTDm+mTwuZJxhq8vi1UcI2HctD7V6/6xO7Wd4koBSqcNkTg8aBIhwb6udiGVAqnGI9
         hVccvIu5CCJ4nF/CUEjUoEH/npRUpvUWy4pIRwt1xz5Xrd8FBOGM6Twmz/K8x5VUeZw6
         CxHiqzGUCqbAPvE3t2wz4cIz4hF7zuKGjAgebqNxv8R0EQhU82pEzGZftwjqt9I9zk4k
         WJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743443712; x=1744048512;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXTV0VWzIghH7eWjopMb8VSJWH0nbYt3yb1dFJgZQTg=;
        b=bFJJ2H/ZVkKA0gq9Dj8K8Ke+WYHKbp9JrQg4HyiPmAa25LRFsi/nHT8zTKpf36lxe6
         6AmOW0TFo2x38E9aBFpm758+JmVTL4/1o6ReTVcU/sSUc1oV8LpHZnfdpHFX/Vgw7cIT
         4uNACsRYjrGv9VKoONdafKQNoafesKCtcoeE8+8412M5zDz82x+oRzj6GFo/w0/LZTLY
         G/4TY2Kgn5e/NLG8+GguyK0onmBz3EdgtHK41+ql4G0tCvlyHaf4cl6YHOvWgy2QdOm3
         PF+c8NQtyONCb5nsHeW7sCk9Fg4qFIqNDHPBkm2zeTBYUkR6OaE1+p+SDuSKH9Ndi/S/
         TZAw==
X-Forwarded-Encrypted: i=1; AJvYcCW+bxdrT4HxxeWhnW2+S4keWfdT3+jWRqvsuo5+hgQH0Sqr8I86Dub2qNbK6p54FQFDrO/62M1XuaEN5FSw@vger.kernel.org, AJvYcCX8m/9Rgn3pUYKX4ekB/0XVnBbHycHliRqrD7h7iokER6fPrb6DZv40xLAE69LxGwIn/88YVpAetX/U@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJr7Ax+LaIJ2l19njaoY9UGihiFP3N9S3YKS8UNcghkyOxRG5
	sTk6qOcX36UG2N58ReUpsnS9exCvIClvXTNeyM+WrMFE1iv2bfIAlhTXVOfY
X-Gm-Gg: ASbGncvIRm3MgXWzjdud8K5Sa2fqyWrNUovfolfMAjzngi08inZlnBOlYUBFBR7XxVt
	1l84tPGZH1Q1/+3VOGj4Zo7ymwdrmt+YTNZ4LGoc3szFeB4P28nR8+CYaSDPvSqNxUkl9X6/oiA
	6N6xLpP8OTKe90qg3sp10bktKK6ABZ9hm4SjFyQNc0hH5NrBmxvMCG+GaOxESGx4yYqIXz+LJnV
	whwvmqPyjb39tJm9QCpKwGT/UwmQ6Hwmxxyn3OSZF+N3pymQhNKH/LGor4nK3KaKsffe0/aKuJY
	kXnqvWKxXIWMGanfEN5iF3va+qsQxaDvivipI9kVUFdS+F3//RGWrAJT
X-Google-Smtp-Source: AGHT+IH/xXI93ke9faWSKBf2mG4FMyJbbgdoQak0Z/9++IGsl4A3a1LlK5tyg/njP7SZPjHykpDxjA==
X-Received: by 2002:a05:6402:42d2:b0:5e6:616f:42e4 with SMTP id 4fb4d7f45d1cf-5edfdd22a1amr10055198a12.27.1743443711992;
        Mon, 31 Mar 2025 10:55:11 -0700 (PDT)
Received: from localhost (13.tor-exit.nothingtohide.nl. [192.42.116.210])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5edc17dff0bsm5895018a12.70.2025.03.31.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:55:11 -0700 (PDT)
Date: Mon, 31 Mar 2025 19:55:04 +0200
From: Ahmed Salem <x0rw3ll@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] ACPI: mark ACPI_COPY_NAMESEG destinations with
 __nonstring attribute
Message-ID: <xxibvztriq62tdzjhubb6ll3tbwghmiynmwxz4jp7clk6x2f7q@ato7owvq5jv6>
References: <cover.1743313252.git.x0rw3ll@gmail.com>
 <a9bd2a1b490b4305c18f8473aab21c97e8902fb8.1743313252.git.x0rw3ll@gmail.com>
 <CAJZ5v0jUO-7t4F09TjpX_Ea-U8i61N=9DWwB3urJ6KQGzFX_-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jUO-7t4F09TjpX_Ea-U8i61N=9DWwB3urJ6KQGzFX_-g@mail.gmail.com>

On 25/03/31 01:49PM, Rafael J. Wysocki wrote:
> On Sun, Mar 30, 2025 at 7:54 AM Ahmed Salem <x0rw3ll@gmail.com> wrote:
> >
> > strncpy(), which ACPI_COPY_NAMESEG currently uses, is deprecated[1].
> >
> > This patch is the first of two, ultimately replacing strncpy() with
> > strtomem(), avoiding future compiler warnings about truncation.
> >
> > [1] https://github.com/KSPP/linux/issues/90
> >
> > Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>
> 
> ACPICA material is primarily handled by the upstream ACPICA project on
> GitHub, so please avoid mixing ACPICA code changes with changes to the
> other code in one patch.
> 
> Also, ACPICA changes should first be submitted to upstream ACPICA, as
> indicated on this list for many times, see for instance:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0gUDxrAn4W+Rf3ifjrg8Z9ZzTTOZjPFSSN5488mPqzXeA@mail.gmail.com/
> 

Thank you so much for the note! In full transparency, I did see that
comment prior to submitting this patch. However, I wasn't entirely sure
whether I should have done that given the nature of this patch.

This marks my second time contributing patches as part of the LKMP, and
I've just got started learning C fairly recently, so I thought I'd
consolidate the changes into this series so if there's anything wrong
with my approach, it would cut the time discussing it over on upstream
as well as mailing lists. Hindsight being what it is, however, I should
have seen the MR from Kees Cook introducing ACPI_NONSTRING before
proposing changes, so that's definitely lessons learned for current and
future reference.

Point taken nonetheless, and I will be submitting the ACPICA-related PR
upstream, and resend the ACPI-specific one here instead without the RFC
tag. My apologies, and thank you so much once again for your time and
effort!

> > ---
> >  drivers/acpi/acpica/acdebug.h                            | 2 +-
> >  drivers/acpi/prmt.c                                      | 2 +-
> >  drivers/acpi/sysfs.c                                     | 4 ++--
> >  include/acpi/actbl.h                                     | 6 +++---
> >  tools/power/acpi/os_specific/service_layers/oslinuxtbl.c | 2 +-
> >  tools/power/acpi/tools/acpidump/apfiles.c                | 2 +-
> >  6 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/acdebug.h b/drivers/acpi/acpica/acdebug.h
> > index 911875c5a5f1..2b56a8178f43 100644
> > --- a/drivers/acpi/acpica/acdebug.h
> > +++ b/drivers/acpi/acpica/acdebug.h
> > @@ -37,7 +37,7 @@ struct acpi_db_argument_info {
> >  struct acpi_db_execute_walk {
> >         u32 count;
> >         u32 max_count;
> > -       char name_seg[ACPI_NAMESEG_SIZE + 1];
> > +       char name_seg[ACPI_NAMESEG_SIZE + 1] __nonstring;
> >  };
> >
> >  #define PARAM_LIST(pl)                  pl
> > diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> > index e549914a636c..ca70f01c940c 100644
> > --- a/drivers/acpi/prmt.c
> > +++ b/drivers/acpi/prmt.c
> > @@ -40,7 +40,7 @@ struct prm_buffer {
> >  };
> >
> >  struct prm_context_buffer {
> > -       char signature[ACPI_NAMESEG_SIZE];
> > +       char signature[ACPI_NAMESEG_SIZE] __nonstring;
> >         u16 revision;
> >         u16 reserved;
> >         guid_t identifier;
> > diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> > index a48ebbf768f9..a05d4032d4f1 100644
> > --- a/drivers/acpi/sysfs.c
> > +++ b/drivers/acpi/sysfs.c
> > @@ -307,9 +307,9 @@ static struct kobject *hotplug_kobj;
> >
> >  struct acpi_table_attr {
> >         struct bin_attribute attr;
> > -       char name[ACPI_NAMESEG_SIZE];
> > +       char name[ACPI_NAMESEG_SIZE] __nonstring;
> >         int instance;
> > -       char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE];
> > +       char filename[ACPI_NAMESEG_SIZE+ACPI_INST_SIZE] __nonstring;
> >         struct list_head node;
> >  };
> >
> > diff --git a/include/acpi/actbl.h b/include/acpi/actbl.h
> > index 451f6276da49..8aa60281e7db 100644
> > --- a/include/acpi/actbl.h
> > +++ b/include/acpi/actbl.h
> > @@ -66,12 +66,12 @@
> >   ******************************************************************************/
> >
> >  struct acpi_table_header {
> > -       char signature[ACPI_NAMESEG_SIZE];      /* ASCII table signature */
> > +       char signature[ACPI_NAMESEG_SIZE] __nonstring;  /* ASCII table signature */
> >         u32 length;             /* Length of table in bytes, including this header */
> >         u8 revision;            /* ACPI Specification minor version number */
> >         u8 checksum;            /* To make sum of entire table == 0 */
> > -       char oem_id[ACPI_OEM_ID_SIZE];  /* ASCII OEM identification */
> > -       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];      /* ASCII OEM table identification */
> > +       char oem_id[ACPI_OEM_ID_SIZE] __nonstring;      /* ASCII OEM identification */
> > +       char oem_table_id[ACPI_OEM_TABLE_ID_SIZE] __nonstring;  /* ASCII OEM table identification */
> >         u32 oem_revision;       /* OEM revision number */
> >         char asl_compiler_id[ACPI_NAMESEG_SIZE];        /* ASCII ASL compiler vendor ID */
> >         u32 asl_compiler_revision;      /* ASL compiler version */
> > diff --git a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
> > index 9d70d8c945af..52026b9e389e 100644
> > --- a/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
> > +++ b/tools/power/acpi/os_specific/service_layers/oslinuxtbl.c
> > @@ -19,7 +19,7 @@ ACPI_MODULE_NAME("oslinuxtbl")
> >  typedef struct osl_table_info {
> >         struct osl_table_info *next;
> >         u32 instance;
> > -       char signature[ACPI_NAMESEG_SIZE];
> > +       char signature[ACPI_NAMESEG_SIZE] __nonstring;
> >
> >  } osl_table_info;
> >
> > diff --git a/tools/power/acpi/tools/acpidump/apfiles.c b/tools/power/acpi/tools/acpidump/apfiles.c
> > index 13817f9112c0..5a39b7d9351d 100644
> > --- a/tools/power/acpi/tools/acpidump/apfiles.c
> > +++ b/tools/power/acpi/tools/acpidump/apfiles.c
> > @@ -103,7 +103,7 @@ int ap_open_output_file(char *pathname)
> >
> >  int ap_write_to_binary_file(struct acpi_table_header *table, u32 instance)
> >  {
> > -       char filename[ACPI_NAMESEG_SIZE + 16];
> > +       char filename[ACPI_NAMESEG_SIZE + 16] __nonstring;
> >         char instance_str[16];
> >         ACPI_FILE file;
> >         acpi_size actual;
> > --
> > 2.47.2
> >
> >

