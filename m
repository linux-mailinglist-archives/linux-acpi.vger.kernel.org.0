Return-Path: <linux-acpi+bounces-387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA27B70DB
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 098652813C8
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 18:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E508538DFD
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Oct 2023 18:31:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758D930CF2
	for <linux-acpi@vger.kernel.org>; Tue,  3 Oct 2023 17:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DBEC433C7;
	Tue,  3 Oct 2023 17:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696352679;
	bh=ojhTT5gbz7npnJ9U/90ySd8WkHi5+4JKHxAn4AYgke8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PXhoVkKbpNQi/DK3FrmfqY+MwrwilW7pkXKe7+HQap+P4a7QAfZ3eBo+KJNWliyrL
	 v3KFw7bu5Y/oVJE6JWR4pH4n1okAU2KBWvJ2tU7YIv96FEbWQdT5LUWWgXLDzrGHiZ
	 YBrZ8qP/ZwZd7sSZ25jEvN8hbpnpm1N2woKVY8YHd9Lkuc1d9pa4f/gFmnaVOEf2bT
	 45UPBF87Mej4mPiZPIJVW5/QLLICqVhbeBpYZd1QfDLD793FGuRxO2g0WnpSzlV357
	 3r2rDBYNM29LdyTR2B9JCpOak+KEbCHxumzCxRpvmf94WNRSGGG0/5/hXvuZg8ZbiL
	 xykSOt2a65VAA==
Date: Tue, 3 Oct 2023 12:04:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] PCI: ACPI: Switch to use acpi_evaluate_dsm_typed()
Message-ID: <20231003170436.GA678206@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002135352.2603096-1-andriy.shevchenko@linux.intel.com>

On Mon, Oct 02, 2023 at 04:53:52PM +0300, Andy Shevchenko wrote:
> The acpi_evaluate_dsm_typed() provides a way to check the type of the
> object evaluated by _DSM call. Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied with Rafael's ack to pci/enumeration for v6.7, thanks!

> ---
>  drivers/pci/pci-acpi.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a05350a4e49c..cf108259aef6 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1215,12 +1215,12 @@ void acpi_pci_add_bus(struct pci_bus *bus)
>  	if (!pci_is_root_bus(bus))
>  		return;
>  
> -	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
> -				DSM_PCI_POWER_ON_RESET_DELAY, NULL);
> +	obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 3,
> +				      DSM_PCI_POWER_ON_RESET_DELAY, NULL, ACPI_TYPE_INTEGER);
>  	if (!obj)
>  		return;
>  
> -	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 1) {
> +	if (obj->integer.value == 1) {
>  		bridge = pci_find_host_bridge(bus);
>  		bridge->ignore_reset_delay = 1;
>  	}
> @@ -1376,12 +1376,13 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	if (bridge->ignore_reset_delay)
>  		pdev->d3cold_delay = 0;
>  
> -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 3,
> -				DSM_PCI_DEVICE_READINESS_DURATIONS, NULL);
> +	obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 3,
> +				      DSM_PCI_DEVICE_READINESS_DURATIONS, NULL,
> +				      ACPI_TYPE_PACKAGE);
>  	if (!obj)
>  		return;
>  
> -	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 5) {
> +	if (obj->package.count == 5) {
>  		elements = obj->package.elements;
>  		if (elements[0].type == ACPI_TYPE_INTEGER) {
>  			value = (int)elements[0].integer.value / 1000;
> -- 
> 2.40.0.1.gaa8946217a0b
> 

