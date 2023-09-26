Return-Path: <linux-acpi+bounces-164-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1197AF53B
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4524628342C
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE204A547
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1768036B1E
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 20:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444A4C433C8;
	Tue, 26 Sep 2023 20:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695759825;
	bh=QFHLMTjVfFoODm26ZFIrHvVeOcyujk2tTFyQNC/M/Rg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MjWHv8j98eTEfeoTeUy6oOaMJVr3ilIAfVIRdA/XlQtKImfw6+BlT13Cebwh1AZq7
	 Z1cukgLGqIQBOFgcFKxLfjCXvLRIA+lo/ZuZWoEZD6XFCmghZDLsi8xodo8TJKDvqJ
	 Ecg4q/yBH9zCbSq7+Gx4CEy5CWb3VImtiGRzlaxUmfg80rQA9KVbBR0UiaZrHoFKDg
	 O+jeagO9b4v3hGOfbDf2pkBW9Bj6hXa2AWdd4FDNOJ39lFwAs8t/j6aoF3RmNHR2LG
	 D40VRWPh4ecLYYWWFvkZchGRcgxU+pZola6qKLXaczLjGr1KOtThzdqYikjRKcUUBO
	 f6RwzRBqgcLjQ==
Date: Tue, 26 Sep 2023 15:23:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, bhelgaas@google.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v5 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Message-ID: <20230926202343.GA419574@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-2-Benjamin.Cheatham@amd.com>

On Mon, Sep 25, 2023 at 03:01:25PM -0500, Ben Cheatham wrote:
> Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
> device) for CXL RCH root ports. The file will print the RCRB base
> MMIO address of the root port when read and will be used by
> users looking to inject CXL EINJ error types for RCH hosts.

I guess this is talking about a sysfs file?  If so, maybe mention that
explicitly in the subject and commit log.

I don't know how you decided to capitalize CXL initialisms and not
"pcie", but I usually use "PCIe".  

> +static struct cxl_port *cxl_root;
> +
> +void set_cxl_root(struct cxl_port *root_port)
> +{
> +	cxl_root = root_port;
> +}

Is there always at most one cxl_root?  Seems worth a one-line comment
at the static data item, since in the world of devices, data is
usually in a per-device struct, not in a single static item.

> @@ -1021,6 +1074,11 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	rc = sysfs_create_group(&dport_dev->kobj, &cxl_rcrb_addr_group);
> +	if (rc)
> +		dev_dbg(dport_dev, "Couldn't create cxl_rcrb_addr group: %d\n",
> +			rc);

Is there any way to create this with an attribute group that the sysfs
infrastructure adds automatically?  I'm not suggesting you have a race
condition here, but using the sysfs infrastructure avoids a lot of
potential problems.

Bjorn

