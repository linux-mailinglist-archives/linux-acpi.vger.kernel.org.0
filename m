Return-Path: <linux-acpi+bounces-7304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DE947E3D
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 17:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CCF283401
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6F15AD99;
	Mon,  5 Aug 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbcljqG+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC6E15A86A
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872155; cv=none; b=IT3x/MfTyKdm5OIj2DRnf4Oxv+deF/cU04+pJmDWe6KTQOt2JC/XDTTmJ9qYiumORny5W/cMeUVCXDrniCVUXBjcHUJ+zwE9mxwpxcS9QjQkTNBfDMkeJMqJPY2IVCdB+/gCwKzJ/ipRkgTb1RkO4gWu6RAChY7ExCVaPmNYSqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872155; c=relaxed/simple;
	bh=v2ERA9o7/xVC+jk2zxDSTBfNpKA5+JJHS1aHhP5v/sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwdfpn1uvdMa74wi+64fdmcjylUlJsuuNQMP5f1xOOIQmribxFqGSC9WlvBpcZkrnAqSGMPuJXU3FEuBZUPELS3S6GbZ8Eao4z/CPMeRpW+Zi0Qr7xNwLNrr9m6AkEyNZT9YS8IfT1hl5S0xbl5mDaiYW1i2aonx1v4/5bdqRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbcljqG+; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70eec5f2401so7716492b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2024 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722872153; x=1723476953; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kaNxJBlznx6y0vjgoBqt7rcaY0nzk8O5nbByfKyVdkM=;
        b=gbcljqG+NpDriZ2wzLDdZYfIEhBjzUYwJJA328LRp3T2z+iTq8Iopvkd0vNy6JO8Pz
         YtGuQzgBNQa6oTBrkt+zv+p6bALdttEp7l2ViQmQ+cVNC4TyT4bwrMHphn+UVka6BHg0
         Q5Zpe3IrWZmT0Xrhzm4DsCA5NrVDWyi3tK1zay97gLUBBTdTi1udpXDgCMBBMDTc4QGp
         u8lRVdvrd8eeKQnLdsmIWVdBu0UqONNipMRiXguERSiY2fJQ9U+/VRowTAkvkA3ZpomX
         yA3DD65e7H2VfuqHf1KRtNtiWtk//GyQeblOvXdpADkU1OHvbYgyH0g233h6BAlc7L18
         cD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722872153; x=1723476953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaNxJBlznx6y0vjgoBqt7rcaY0nzk8O5nbByfKyVdkM=;
        b=EWc0DUuRr3TxYQqdhUgJABnLzfVViOW0Fycg/rUsUCVg9YX/OelP3O/31CK4jySyWL
         jlzY7imJlarGswK+clI48vpKwNes44iTjIWrCXGPJxXFR2/ZeyA68rMg2ynwUQFVwT7k
         0qS/3XL2V+jftwKb3gvylrBtHwrR9ng1DhIJjHkDdFu0rjtJ/K4oJug5UNEkWpsL/3c2
         5pcN9W6G6IPDbOzJsHiOPRDjiNg2HnGucC+PszbxTzZvumkdR8JOncmJo0WC09xD6YhX
         OzbA9incIqY+VF0vD2nP9r3gLAbNR5Mym06ZtDBwFnlo9+E0zIfrpOJc/GB/CN+St2rl
         7hWw==
X-Forwarded-Encrypted: i=1; AJvYcCVpR/PfgqJVlc999WlEsDaIvzv8Q5Vo17u64KMMyY+H6goQrFy6fZNol4msbTjWUf5njgdvVsHrw7ZCs0NR3dl7W+c8hDmWmJEU1Q==
X-Gm-Message-State: AOJu0Ywkn2Y2118dBTP788VYsk8nM0+LqEu5LfK/ELg+fOmChi8usldm
	p+4+KoJ6mPaYoeMQYzO8jBI12+Vdw8vvfkPWiBEmEwMD5Pgfq+5tWtviEmnXIA==
X-Google-Smtp-Source: AGHT+IF/U0Q1PobUn7t5WL8VXgXR+W38KeWOWYVnqFO/t8f7Bw/Vwj5BN+d89aomfHaopFlJNaJ26g==
X-Received: by 2002:a05:6a00:21cf:b0:70d:281d:ee8c with SMTP id d2e1a72fcca58-7106cfdca5dmr14410623b3a.18.1722872153206;
        Mon, 05 Aug 2024 08:35:53 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc344sm5543790b3a.151.2024.08.05.08.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 08:35:52 -0700 (PDT)
Date: Mon, 5 Aug 2024 21:05:46 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com
Subject: Re: [PATCH v4 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240805153546.GE7274@thinkpad>
References: <20240326-pci-bridge-d3-v4-0-f1dce1d1f648@linaro.org>
 <20240326-pci-bridge-d3-v4-3-f1dce1d1f648@linaro.org>
 <CAJMQK-hu+FrVtYaUiwfp=uuYLT_xBRcHb0JOfMBz5TYaktV6Ow@mail.gmail.com>
 <20240802053302.GB4206@thinkpad>
 <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJMQK-gtPo4CVEXFDfRU9o+UXgZrsxZvroVsGorvLAdkzfjYmg@mail.gmail.com>

On Fri, Aug 02, 2024 at 12:53:42PM -0700, Hsin-Yi Wang wrote:

[...]

> > > [   42.202016] mt7921e 0000:01:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x300 @ 77, parent: 0000:00:00.0
> > > [   42.231681] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> >
> > Here I can see that the port entered D3hot
> >
> This one is the wifi device connected to the port.
> 

Ah, okay. You could've just shared the logs for the bridge/rootport.

> > > [   42.238048] mt7921e 0000:01:00.0: PM:
> > > pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26583 usecs
> > > [   42.247083] pcieport 0000:00:00.0: PM: calling
> > > pci_pm_suspend_noirq+0x0/0x300 @ 3196, parent: pci0000:00
> > > [   42.296325] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
> >
> This is the port suspended with D0. If we hack power_manageable to
> only consider D3hot, the state here for pcieport will become D3hot
> (compared in below).
> 
> If it's D0 (and s2idle), in resume it won't restore config:
> https://elixir.bootlin.com/linux/v6.10/source/drivers/pci/pci-driver.c#L959,
> and in resume it would be an issue.
> 
> Comparison:
> 1. pcieport can go to D3:
> (suspend)
> [   61.645809] mt7921e 0000:01:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x2f8 @ 1139, parent: 0000:00:00.0
> [   61.675562] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [   61.681931] mt7921e 0000:01:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 26502 usecs
> [   61.690959] pcieport 0000:00:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x2f8 @ 3248, parent: pci0000:00
> [   61.755359] pcieport 0000:00:00.0: PCI PM: Suspend power state: D3hot
> [   61.761832] pcieport 0000:00:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x2f8 returned 0 after 61345 usecs
> 

Why the device state is not saved? Did you skip those logs?

> (resume)
> [   65.243981] pcieport 0000:00:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3258, parent: pci0000:00
> [   65.253122] mtk-pcie-phy 16930000.phy: CKM_38=0x13040500,
> GLB_20=0x0, GLB_30=0x0, GLB_38=0x30453fc, GLB_F4=0x1453b000
> [   65.262725] pcieport 0000:00:00.0: PM:
> pci_pm_resume_noirq+0x0/0x190 returned 0 after 175 usecs
> [   65.273159] mtk-pcie-phy 16930000.phy: No calibration info
> [   65.281903] mt7921e 0000:01:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3259, parent: 0000:00:00.0
> [   65.297108] mt7921e 0000:01:00.0: PM: pci_pm_resume_noirq+0x0/0x190
> returned 0 after 329 usecs
> 
> 
> 2. pcieport stays at D0 due to power_manageable returns false:
> (suspend)
> [   52.435375] mt7921e 0000:01:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x300 @ 2040, parent: 0000:00:00.0
> [   52.465235] mt7921e 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [   52.471610] mt7921e 0000:01:00.0: PM:
> pci_pm_suspend_noirq+0x0/0x300 returned 0 after 26602 usecs
> [   52.480674] pcieport 0000:00:00.0: PM: calling
> pci_pm_suspend_noirq+0x0/0x300 @ 143, parent: pci0000:00
> [   52.529876] pcieport 0000:00:00.0: PCI PM: Suspend power state: D0
>                 <-- port is still D0
> [   52.536056] pcieport 0000:00:00.0: PCI PM: Skipped
> 
> (resume)
> [   56.026298] pcieport 0000:00:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3243, parent: pci0000:00
> [   56.035379] mtk-pcie-phy 16930000.phy: CKM_38=0x13040500,
> GLB_20=0x0, GLB_30=0x0, GLB_38=0x30453fc, GLB_F4=0x1453b000
> [   56.044776] pcieport 0000:00:00.0: PM:
> pci_pm_resume_noirq+0x0/0x190 returned 0 after 13 usecs
> [   56.055409] mtk-pcie-phy 16930000.phy: No calibration info
> [   56.064098] mt7921e 0000:01:00.0: PM: calling
> pci_pm_resume_noirq+0x0/0x190 @ 3244, parent: 0000:00:00.0
> [   56.078962] mt7921e 0000:01:00.0: Unable to change power state from
> D3hot to D0, device inaccessible                    <-- resume failed.

This means the port entered D3Cold? This is not expected during s2idle. During
s2idle, devices should be put into low power state and their power should be
preserved.

Who is pulling the plug here?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

