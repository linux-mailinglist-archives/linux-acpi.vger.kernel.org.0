Return-Path: <linux-acpi+bounces-20185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D1D121BB
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 12:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB7753019C58
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jan 2026 11:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD28352C38;
	Mon, 12 Jan 2026 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TT7YqFfm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A204352931
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215599; cv=none; b=DXOT3Nofx53ar1SIp/T0KAZZixwA/K19eGc8h2HH2A2PFylKMZt57eQAL1TujHX25l/eMPU4OpJDky4OXAPqU+qVyCiGQUgcxl04A2bIkRESiUUkeKdR6QDt5BTp4dBUVRQ57DSir3jXw3QmVCf62prlvxRyR4RftwCF4XIbOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215599; c=relaxed/simple;
	bh=w4Qzn35STbVzOOJPdSKL2VEF9nGgF6PkL/Y8CksEVCE=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyP94PCffhzhWHc05WXz4Yz59qLxrgdJFcPW2L9Ww7wRiug4mXCJpRV4FTTyFbzQfS2cBLzx0UOe2k/ezrz9PAm9Pc1jfF9vMWLFQLmz+bQminxeNbFjievM0sHDX3eFRC+ohxVTwDiIGhjayhD9X7WXdgWYdtC1aQCNrf87UJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TT7YqFfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C964CC2BC86
	for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768215598;
	bh=w4Qzn35STbVzOOJPdSKL2VEF9nGgF6PkL/Y8CksEVCE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=TT7YqFfmwZgr5dyYyF2HUOqSA23div/+DVDuKXOXga0BPLcAPW/mlMu2vXVjNkdBl
	 4h3nqq6p9hpK77dpGT74NZagylN8qcbYhXKh/mQpRb3zP2plNO5kWsbB4ov9iYt350
	 gzGFzN4yAN3u4eDINYQrOkdbOsr9QPlvQYrzNukVeWdGgA+efoATOl0AJ+PYW1Na2L
	 Ki7SPLEkBtIU0EasNw9XfS7CIrISNYyN3fH83nwrItHpSsDIRA2barBGAUFKzshkj+
	 xw4/bVdxTF29+1ZyNk+4sT7Dfl7WeRYF8W5JtIWV6Uo85VF/5ViigFItYoyTa1f+hj
	 wK+dnnrawzSXA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b67388c9cso7890164e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Jan 2026 02:59:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqTQfrxAErSdQLEHPCIkcJNlIgjf902vAJ1nyIilatbZUeeZgF0zCKE8edFt509vuOlN/z/EtYQX1j@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHF/kPP16Nkyxyr6MYegAVuLJ/KFrQVWOx05NBGLkFzjxZEdH
	9T7EDHxvgC6S7tlqVrSbzJBX5xoBGoZWPoxLPEL49+NR0979h0atLKMD8yrmWA1LqQdDU+Weg2K
	XJrL8GPwow1xo/rESxMpg/B/SRlbYf48IFUVLI9R/bw==
X-Google-Smtp-Source: AGHT+IHNHSsmtNKOq7dZuyb4pj5TKMzAvZn1CXByMQfqksILI3gJ7/QvG9QW8K7pgPGHhT94iYmkam0+aFCi/LDGdCM=
X-Received: by 2002:a19:c507:0:b0:59b:7016:951c with SMTP id
 2adb3069b0e04-59b701696e8mr3916829e87.48.1768215597459; Mon, 12 Jan 2026
 02:59:57 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 04:59:55 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 04:59:55 -0600
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <xbzcmhuebjlhsn7zumudeel7dbcmrslxcrxde23rgxrmvoy73h@aj6yxcpuzh46>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-2-4faee7d0d5ae@oss.qualcomm.com> <aWSnyc8Eiq56ckXB@smile.fi.intel.com>
 <xbzcmhuebjlhsn7zumudeel7dbcmrslxcrxde23rgxrmvoy73h@aj6yxcpuzh46>
Date: Mon, 12 Jan 2026 04:59:55 -0600
X-Gmail-Original-Message-ID: <CAMRc=MdKNXkXeEBp_v=2A5VbZQzJ=GcGMJcNvZHqOOEjTwBHZw@mail.gmail.com>
X-Gm-Features: AZwV_QhzEzG4uyQUb1rUQTP8FyUWpOKeUYvBnTUZu3WXZhiFHsa_xogssFzjH94
Message-ID: <CAMRc=MdKNXkXeEBp_v=2A5VbZQzJ=GcGMJcNvZHqOOEjTwBHZw@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 08:55:21 +0100, Manivannan Sadhasivam
<mani@kernel.org> said:
> On Mon, Jan 12, 2026 at 09:50:33AM +0200, Andy Shevchenko wrote:
>> On Sat, Jan 10, 2026 at 12:26:20PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>
>> > Add of_find_serdev_controller_by_node() API to find the serdev controller
>> > device associated with the devicetree node.
>>
>> Why OF-centric code? No, please do it fwnode-based.
>>
>
> No issues for me. But the existing APIs in serdev are OF based. If uniformity is
> not needed, I can change it to a fwnode based API.
>

Using fwnodes here shouldn't be an issue, even though serdev core assigns
dev->of_node, it will be converted to dev->fwnode when the device is registered.

Bart

