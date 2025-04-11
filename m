Return-Path: <linux-acpi+bounces-12978-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5E5A8603E
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1447ABAE9
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B91D1F3BAD;
	Fri, 11 Apr 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXad2fQu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9817C208;
	Fri, 11 Apr 2025 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380927; cv=none; b=c0lbAY2MzSy51z8Ap6m5Q095U99I++E2KLaJHwM0v+9c9OS7L13bx8W1cg+xog0s8kU5pP0Poeob4p8tCuA69sgOcj0Ch8o9UbqNKRg+d+nSfzVfmxy+gKzMjO9zEg/bHFeg3ciDjXA/2OcTy9+zFmqjF8wly0EktmN2aq/FWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380927; c=relaxed/simple;
	bh=FSFkpzzGGBz0qe7fkRYUbnTeO49Cx5ANriYjuk/BOZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtVJobNlpFtYlJv9EoUd8oRElwSBOq8vSbywpHcAy/d5NvrDT8WAa24ZEcXbhD4JNPLO3hi6TgjGfX+K9qeTkY0AG9vUpvfkkZepsm1hrW4LB7RQ4V7hWAm9d4+tVbUvKF+b0bceomeD87+bjBaTNZ6rcAIX2eLZFvFVbx/kFeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXad2fQu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224341bbc1dso19374985ad.3;
        Fri, 11 Apr 2025 07:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744380925; x=1744985725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+G9Jy1y2uI9JGUJS5ikQwWYrZoZSDBZRFdvs7aJRh8=;
        b=NXad2fQupQu9+mPMt9YgZZD5hB5nZgAGdD2AR55t9wCnqpy7G4UzPgc3nKF5K1yhpu
         my2aAV3F6nUGTIyioDBs8zh3t6NUFdt1XBlGUZOOU2MAVYhkMuuU/1esdl/SJEvM5izU
         Zb0Cm9qpfjTIttaJr4biP7aXSI29mniVgBA1RMKbDqd+lr2p/1J+W034aClKuLzhMqkf
         v+zYRtB+FKrJ0OKup4oCQSGj7jnBTCz4TurOiPdEDiHgBUP4/xW+VM+jB3b06YhhD5zr
         7dwrglgi58xtcQqlqiAoCRCShUJByNpDwEdeA9lL7hq2mIRxFbXt9wYyXVJSIoqS5168
         VQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380925; x=1744985725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+G9Jy1y2uI9JGUJS5ikQwWYrZoZSDBZRFdvs7aJRh8=;
        b=idjYepTZ6kw7Hst2c03nkJzHdXe9Vw4gCJ25gZCtSmmVcIZFAtcGzuLefYqr5RJCc2
         oFiq05fyPQC3sXb7Lv+83LAZjaUH9VaB0lgql/9ExP3yY2o7/V8+3btPkw9Ma2DvM5Z2
         iQy97FtYAVF7LDRMkX5Q2kzunvIqGm4JTIATGmZGF8DbRdcC2rk4KNpE7RxxDVTjA19z
         hKi7DSGRLAwY9+Hv+JfFVY12kGQbbyhecMaKUQex7ypP2q1iRIYIBGGKUja61cYIvWvq
         6nk7hBpYW6236eiHDJK8S/YKb9dAsNOfhT5x1AHWrRyAlYt05BB05i6ruSGzAvINW0/l
         6z1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4BUVjzUo5iXPdR3QWwYpHDZ2EgoV9qurBuabOJk0XYxo4KeWca48sT4c9bjX5Nh15pMSacKb+JbnAuQ==@vger.kernel.org, AJvYcCW3pW2ws6OOa10chcbDjhgRQzPW6tHk0BsUa6cStF9PgzbxMCpX+YhFmdw8yJkZwV3177+UeSOjKd2tcciu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8i+fgAsQ+kjL/rxP3kOb6txyQxlvUs+FrMJ5jZksDTyiA9Gtp
	iBu00eBiufz9LJ1F/hqAvSEKvLUmdHTTk41twCkghOyvQlwezIrWzgPYKw==
X-Gm-Gg: ASbGncuT1o7bca859OrA2Ds5Opa7wIYbsGcon4WFHD8+ZwiRqKwDvaPLuUXth+UQ66p
	7oJd08sUhaDnkdpKyCybgHaHBxSpXPEWoW5A+0LoYVFrSGh4yln8zeQMhSySrm+ZQ7jobigq+tD
	Bt/AaiP34UacAmomaKqCa7XGKq5BB/jle5enlUfVoCA6GA0aKGyWxEIgk4B93q5gvLeQC4Oaxu5
	wmOvkXXR0fz3ezNTWa38Q/SyArFB4K5RzRdYhPOeaQse4hh+zxyxiRCc+IAiRsl+Y1PFEHGpw5p
	e5/RFM3dzIPA4J1xGvBDOoSpznibhZsb0T/SnlVgp8gchfJbvFb7og==
X-Google-Smtp-Source: AGHT+IFHbAnB2ypXi79cUfpFWUCDRj63BaQojKKoxescZtrzPLPM7NbB/idMuzVDAo84gc/ucjri3A==
X-Received: by 2002:a17:902:d550:b0:224:1ec0:8a0c with SMTP id d9443c01a7336-22bea4bd74dmr47046475ad.29.1744380924516;
        Fri, 11 Apr 2025 07:15:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb529esm49223525ad.168.2025.04.11.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 07:15:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 11 Apr 2025 07:15:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 11/13] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
Message-ID: <0be30d7d-f091-4497-bb72-fdcad276285e@roeck-us.net>
References: <20250313-pcc_fixes_updates-v3-0-019a4aa74d0f@arm.com>
 <20250313-pcc_fixes_updates-v3-11-019a4aa74d0f@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-pcc_fixes_updates-v3-11-019a4aa74d0f@arm.com>

On Thu, Mar 13, 2025 at 03:28:57PM +0000, Sudeep Holla wrote:
> The PCC driver now handles mapping and unmapping of shared memory
> areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> this xgene hwmon driver did handling of those mappings like several
> other PCC mailbox client drivers.
> 
> There were redundant operations, leading to unnecessary code. Maintaining
> the consistency across these driver was harder due to scattered handling
> of shmem.
> 
> Just use the mapped shmem and remove all redundant operations from this
> driver.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Not that it matters, but I keep wondering: Why don't people use auxiliary
devices for situations like this, and keep the subsystem code where it
belongs ?

I am not requesting that you do it, I just wonder why the mechanism isn't
used. I would have thought that it would be perfect for situations like
this, so I guess I must be missing something, and I'd like to understand
what that something is.

Thanks,
Guenter

