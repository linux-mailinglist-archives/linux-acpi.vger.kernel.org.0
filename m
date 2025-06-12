Return-Path: <linux-acpi+bounces-14295-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A19AD6928
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 09:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE80D7A8E56
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E32036EC;
	Thu, 12 Jun 2025 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SF+m+Ibw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028621FDE19
	for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713692; cv=none; b=Z8/f9I27Mra6P1lVYmlXKqDB5uo7gOYdud1rpXvGrjyQVBz2W3HETRL4LTTUvsDdyXGl2/PIGB2ww5gbxBXj4QIyZaKeAAJ3VnVq8olF6IzPjov7BHiQyBWgsUVsv2wTHGWdkEFosnNPNemVkK3SDxgGvMIeDd5+CX/nyU8VVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713692; c=relaxed/simple;
	bh=xrhWrgv0o3xC88dnn/F3bRNrzuffJWSBuTj+T0FdoT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwYzGojzxODvNk+ecLjN9kCquL6uolP1PnVGSu80KDumXuIaHmIi3YLZDlLXxi76FeB9YUxKIhZx3EbiIOF1YnMILzRIdC0vev9BqEm4zyAPsnP6l0jrNGuBUrdeYjdEYMSug+VChgWOQx1OTtp3ajCepXMUTddKNT2dosM/SNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SF+m+Ibw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cf0120cdso4885745e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 12 Jun 2025 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749713689; x=1750318489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A2sySKdQ4CQJ8gh7cRWEfMp7o4K5xoI+As/ZgZopg1M=;
        b=SF+m+IbwiPVINKIDxBboddT1DmsbRuJl/ZJ+T39KVygpKCpBv6iujsHEcdH/Sb0tI+
         zgsUh0DIyFqVCDWQQ/8LvU5iYtuzfktwrEXxUNGwVeTb/kFY2iuwrRaWmnNFr1o+ILSm
         0bDv+ch8jdWbQfXuXFnh+XfIoAUXRxSmZMjq64u6IMuanfsBPwKc3K+ADXaXxumObl3p
         rmYFnuoeZI+Muf6El6JBWLZ6EVsHRIjjg8AD0GPx2wTY7POB9J1iU3QqtpIJc1ZFdvxA
         WzbHqIH4ZUZr5gF/Z8P5DwMnkZnUG/vCr3EZMA6kMpSwyIvhZ0iAWfl4mAVm1Lx0fnAs
         biOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749713689; x=1750318489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A2sySKdQ4CQJ8gh7cRWEfMp7o4K5xoI+As/ZgZopg1M=;
        b=vbsVV5bm2cpG7Slp9u1K1yBHG9qFEPFhy/1OUfQ6F4kbF28HEDEDtdla/IzG02tCC9
         qzQpQzegr1DmJhUjVswmrmJrtL+BWEe/p5d/SOEbMAtcEpRSsptbhqm3pz2WUkdMUb0j
         XUpeLD5Vw47vaxDLEa9+RkiTu93p1elfeppjAFuEbQdagkkqhLWNkIqto8YM58q5hk+I
         ouM42CvcGTNO3uYl/5/LphHN+ZqdF0gIZBKbc0+udsloq8nw6TBUAiPAGnVlRbxn3GFZ
         biZscVe8AZkPdKpFt9jrVqQyHQ+Mlws6+PX8dINmOCKRp2OpGGJYDKNUFMVQerG4eaG5
         dwHA==
X-Gm-Message-State: AOJu0Ywunjya+6z1avSA5UNqt2GcNUdS5Z8MC5Y8xsMmGJjSPP5IOx+9
	fptuhxHHM/NlrxXK2+hz4ToxiXd7HHXf1HbS/Ft5DAYQYTiDCAk1EE5+7tu+RBCvrQI=
X-Gm-Gg: ASbGncs1kp2nwwQkW5WALPwdyUQ/c6eAJFgK7qEdH0AyScU8oNYYAL+9CSPoWg8L7rO
	lXb/c1xjrEgvkMGVGQ6gF4A9sHN7+Bl/uez0ObJDnwAljT1WA9wFrzebKXwEqED2iEbgeaqHiMl
	hvpwCRf5q++WMOkg+2TNNS9qLBz3+KyRCkEJBK0zKM3cynNKRin8jyy/GPOWD3PKK8kF3dfmlzT
	uHrJ6ofV47f+ptU6ttCytowXuGgwqYRtNhTchtch3EfW70GuxpGRqDAAYaSA4lqTJdFXAJScjzE
	zKxTG8o+xQO3XhD3hMQ1/LNdQiWwaPIkmg2Oy/Qi+hQy/4557HcolHRbcY2ivF4hpbk=
X-Google-Smtp-Source: AGHT+IFDvK071IziOTjAIKa5tXmIXjsqqiN/A9yFxauYtKFLt/j/E47QuRLBSMYz5KDhL1nlE0M31Q==
X-Received: by 2002:a05:600c:3b8f:b0:450:d5c8:29ae with SMTP id 5b1f17b1804b1-4532d2bd8d4mr14882605e9.1.1749713689268;
        Thu, 12 Jun 2025 00:34:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e25302dsm11313175e9.26.2025.06.12.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:34:48 -0700 (PDT)
Date: Thu, 12 Jun 2025 10:34:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
Cc: linux-acpi@vger.kernel.org
Subject: Re: [bug report] PCI/ACPI: Fix allocated memory release on error in
 pci_acpi_scan_root()
Message-ID: <aEqDFMl2cwrmA-Uj@stanley.mountain>
References: <aEmdnuw715btq7Q5@stanley.mountain>
 <CALhs5=1-QP04GEMUjMHgpCtAbUmW=zFpR=7B4KLuJ1wkT2JQmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALhs5=1-QP04GEMUjMHgpCtAbUmW=zFpR=7B4KLuJ1wkT2JQmg@mail.gmail.com>

On Thu, Jun 12, 2025 at 01:12:43PM +0800, Zhe Qiao wrote:
> Hi Dan Carpenter,
> 
> On Wed, Jun 11, 2025 at 11:15 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Hello Zhe Qiao,
> >
> > Commit 631b2af2f357 ("PCI/ACPI: Fix allocated memory release on error
> > in pci_acpi_scan_root()") from Apr 30, 2025 (linux-next), leads to
> > the following Smatch static checker warning:
> >
> >         drivers/pci/pci-acpi.c:1712 pci_acpi_scan_root()
> >         error: double free of 'root_ops' (line 1711)
> >
> > drivers/pci/pci-acpi.c
> >     1667 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
> >     1668 {
> >     1669         struct acpi_pci_generic_root_info *ri;
> >     1670         struct pci_bus *bus, *child;
> >     1671         struct acpi_pci_root_ops *root_ops;
> >     1672         struct pci_host_bridge *host;
> >     1673
> >     1674         ri = kzalloc(sizeof(*ri), GFP_KERNEL);
> >     1675         if (!ri)
> >     1676                 return NULL;
> >     1677
> >     1678         root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
> >     1679         if (!root_ops)
> >     1680                 goto free_ri;
> >     1681
> >     1682         ri->cfg = pci_acpi_setup_ecam_mapping(root);
> >     1683         if (!ri->cfg)
> >     1684                 goto free_root_ops;
> >     1685
> >     1686         root_ops->release_info = pci_acpi_generic_release_info;
> >     1687         root_ops->prepare_resources = pci_acpi_root_prepare_resources;
> >     1688         root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
> >     1689         bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
> >     1690         if (!bus)
> >     1691                 goto free_cfg;
> >
> > The acpi_pci_root_create() function frees root_ops on error in
> > pci_acpi_generic_release_info().  I think there is only one error
> > path where it frees "ri->cfg".  I probably would advise you to re-write
> > the the error handling in acpi_pci_root_create().
> 
> Thanks, this is really an unexpected gain for me. I didn't notice that
> the memory
> release operation has been implemented in the pci_acpi_generic_release_info
> function. But I think it's a bit unclear in the code logic to release
> these memories
> in the pci_acpi_generic_release_info function. As you pointed out, I
> want to let the
> pci_acpi_generic_release_info function return directly, and put all the memory
> release operations into the error handling part of the
> pci_acpi_scan_root function.
> What do you think of this? If you have any better suggestions, please
> let me know.
> 

Either way is fine with me.  I understand why we tried to do the
free in acpi_pci_root_create() but that approached didn't free
"sysdata" reliably so it's not like we can just revert your commit.

If you take your approach you'll have to change pci_acpi_scan_root() as
well.

regards,
dan carpenter


