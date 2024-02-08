Return-Path: <linux-acpi+bounces-3295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436784DD49
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 10:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5106E282900
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Feb 2024 09:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BA36A8BB;
	Thu,  8 Feb 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="tudDLVEs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E8B6BFC9
	for <linux-acpi@vger.kernel.org>; Thu,  8 Feb 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385974; cv=none; b=jHZ4zWAIYx5J14e+QPNjbCzmIPai+dPK9XfQg6/9EpjjIwevuRhoER1Rxba66o3tFAlnxvePwPJJA3o6ERbM+xfvvknVrQSu2Eg0qG9cGKCqI7eE0yMrXAHTVqe+mEuFrL1ouBNPqKufO/53G5rtjrpPMi677SEqvBskYSr+C4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385974; c=relaxed/simple;
	bh=HHlgklhEHH9O7ta3u1cLYxPyu4OGTsMH97Y+4IfEOao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnTl94ndbmDtvMunhQpUeQdcadADLkJlUxQXfdggln7JBud4G3okSh3m4A9ehfIE9bkB0dnXMUb+3LwlRtUxMMM8n8CYVwgZf3IyF9/ElGK/zPhNz2Yzze59LT+2A7z2ZpMYYWMGpQYWCfjVge9wt+s2hU0Qtnsn4Q5nl/fsGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=tudDLVEs; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc26698a5bfso656412276.0
        for <linux-acpi@vger.kernel.org>; Thu, 08 Feb 2024 01:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707385971; x=1707990771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVZrDw08jx/+WS3cBHZbP06Mv/MXnXO3+N5Y9WPwJKc=;
        b=tudDLVEsisWPpzROJ05zczqStpTC8X0SOAFddSbSaxuZFzK1SN/PbP/b0CuNcjcure
         z/SOjMtL7nbtokwWJvW3aEWZm5fynOYSJ59tSRxrLZo569vUaljHRd7XCi+Kn/OK6KEQ
         nUmxS6bdU1/lYN/Bl4uHc50YKB35J5aOERL+Y4zfVXdI0npdohoCRQXXcI2AY9tk5EUG
         feuH5oNF/rVaPZ3w3TAkbEpC7CjkcuNvfvWES33iVXe+cKKmu04wVQ6HPulxAoYi+LEg
         uHDEandfUYdKuu87QdwCPM/rEBYNNMNWncjl9r5SZg83warV24aZ7mYoEknN43qnvSHh
         Kcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707385971; x=1707990771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVZrDw08jx/+WS3cBHZbP06Mv/MXnXO3+N5Y9WPwJKc=;
        b=mx4W5rEq1GD4+uWRttJb0De7ZiiQ/D0HUY1Z8AK6uaQtBHSjOz+/ZFsW+Xq0r4n1zs
         X7EPa+tO7NQZgRAtZIr2Kbr8dJvJqvsIS9qIckK2FuwW5QY8FS8h8D0555YtvwrnJxm5
         Ikyk7uxpovTbzNnrotjqtCSDfiZeN25pdJ3tHN3NcLX33jiqnCAmJRLVnVu5BjebMtP6
         VQGoLLqWEPEhXE5mk0NhgF2xUqgV3H5KJV/rX6SEBmw3ueJ5xbB4/P28lb1RbCSuQGYk
         ex146Z1R/LR2a4d9x18T/EmfaanPfonnMkLS6FCEK+NLE34a3P9DM8ofqN4Ri0y7hQVO
         AuXg==
X-Forwarded-Encrypted: i=1; AJvYcCWRudD70TyCNFDrd4s82VeSKEGD1Zkh1QQ817xiVeKIadv2xXeY1/6cDXY+9iKGLNIi5pq4/5WiT3FsdVzewXEuVjxwCIZnQ+cXJQ==
X-Gm-Message-State: AOJu0YxXnpA9zYZmbfTSsffQNhBBV8x9KbPvWbvFZoz9yk4UwxAvPEqC
	azwfo0ZRQvRm+HQQ3XbWavoHcVnvyC+8bEvRn/5nCIgWAMOqVolUwgRDOycHBrib3GOGVne84DU
	yWZBPvkMdfDppRGGdxv2yYECkqCgjn1I5xRZAUg==
X-Google-Smtp-Source: AGHT+IHznbxnmQ2a9sE2uljICDUHwGrSmpOZeuPsWRerpchjYqZKcjzMU9+eJU7z/zz7WRh/gKnst+hmhjZTufwjTUc=
X-Received: by 2002:a25:8002:0:b0:dbc:b927:c5f9 with SMTP id
 m2-20020a258002000000b00dbcb927c5f9mr7187786ybk.6.1707385971607; Thu, 08 Feb
 2024 01:52:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207200538.GA912749@bhelgaas>
 <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
In-Reply-To: <CAD8Lp47DjuAAxqwt+yKD22UNMyvqE00x0u+JeM74KO2OC+Otrg@mail.gmail.com>
From: Daniel Drake <drake@endlessos.org>
Date: Thu, 8 Feb 2024 10:52:15 +0100
Message-ID: <CAD8Lp44-8WhPyOrd2dCWyG3rRuCqzJ-aZCH6b1r0kyhfcXJ8xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 9:37=E2=80=AFAM Daniel Drake <drake@endlessos.org> w=
rote:
> > What would be the downside of skipping the DMI table and calling
> > pci_d3cold_disable() always?  If this truly is a Root Port defect, it
> > should affect all platforms with this device, and what's the benefit
> > of relying on BIOS to use StorageD3Enable to avoid the defect?
>
> I had more assumed that it was a platform-specific DSDT bug, in that
> PEG0.PXP._OFF is doing something that PEG0.PXP._ON is unable to
> recover from, and that other platforms might handle the suspend/resume
> of this root port more correctly. Not sure if it is reasonable to
> assume that all other platforms on the same chipset have the same bug
> (if that's what this is).

Just realised my main workstation (Dell XPS) has the same chipset.

The Dell ACPI table has the exact same suspect-buggy function, which
the affected Asus system calls from PEG0.PXP._OFF:

        Method (DL23, 0, Serialized)
        {
            L23E =3D One
            Sleep (0x10)
            Local0 =3D Zero
            While (L23E)
            {
                If ((Local0 > 0x04))
                {
                    Break
                }

                Sleep (0x10)
                Local0++
            }

            SCB0 =3D One
        }

(the "L23E =3D One" line is the one that writes a value to config offset
0xe2, if you comment out this line then everything works)

However, on the Dell XPS system, nothing calls DL23() i.e. it is dead code.

Comparing side by side:
Asus root port (PC00.PEG0) has the PXP power resource which gets
powered down during D3cold transition as it becomes unused. Dell root
port has no power resources (no _PR0).
Asus NVM device sitting under that root port (PC00.PEG0.PEGP) has
no-op _PS3 method, but Dell does not have _PS3. This means that Dell
doesn't attempt D3cold on NVMe nor the parent root port during suspend
(both go to D3hot only).

Let me know if you have any ideas for other useful comparative experiments.

Daniel

