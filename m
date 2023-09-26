Return-Path: <linux-acpi+bounces-165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9787AF53E
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 22:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id B27AFB20BF1
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1D4A53D
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Sep 2023 20:32:52 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2654999D
	for <linux-acpi@vger.kernel.org>; Tue, 26 Sep 2023 20:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8177C433C7;
	Tue, 26 Sep 2023 20:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695759895;
	bh=CR25qClzA8w26w2bpWrG5DXhyjWZEg9+8VwxYsxisV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XdLHZyiT1w+yDO1l/aq9u5Tn5FRcaD5P+lTZYc/V1r4EWYX/HxxFTY2YYEl7UfkwF
	 SprK5SdphkPMIoXpgR50e0io4NIKjb4PB7JsarlnAIquRpkqIveaSdmUDljurxXdVc
	 BwiV0H1eg5ubESpEL859rNSM1wskLMT4/3VPUPrSmT5tgpBy5CwKfXMo4wL5j64zBi
	 mGFVQSO13ODBOGTqM/rJNzmfKW8LXsOGbp1VoYBjjgcwGlJtFXsY7jeZbL3Z9/dIhR
	 hI2Wi6kI5Apa5VJxof5lyP9/cWhi/aA0Vhey6xYULnd+qHv7MPKseEMlzLisAJW+PO
	 ISdvUm1uViT8g==
Date: Tue, 26 Sep 2023 15:24:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, bhelgaas@google.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v5 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Message-ID: <20230926202454.GA420013@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925200127.504256-4-Benjamin.Cheatham@amd.com>

On Mon, Sep 25, 2023 at 03:01:27PM -0500, Ben Cheatham wrote:
> Update EINJ documentation to include CXL errors in available_error_types
> table and usage of the types.
> 
> Also fix a formatting error in the param4 file description that caused
> the description to be on the same line as the bullet point.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> ---
>  .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 4 deletions(-)

I always feel like the documentation update should be in the same
patch as the new functionality so it's easy to match up with the code
and keep things together when backporting.  But I know that sentiment
is not universal and maybe there's good reason to keep them separate.

> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index d6b61d22f525..c6f28118c48b 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -32,6 +32,9 @@ configuration::
>    CONFIG_ACPI_APEI
>    CONFIG_ACPI_APEI_EINJ
>  
> +To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set to the same
> +value as ``CONFIG_ACPI_APEI_EINJ`` (either "y" or "m").
> ...

