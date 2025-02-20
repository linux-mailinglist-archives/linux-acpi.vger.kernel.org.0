Return-Path: <linux-acpi+bounces-11339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64861A3D126
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 07:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437401743D9
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Feb 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D493D1DF960;
	Thu, 20 Feb 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blN9Cx43"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51C71BE86E;
	Thu, 20 Feb 2025 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031820; cv=none; b=a6c7cFyD2rzRVDOzjCTd6OXfBYDfJURuUbE7unr3BasCLDlK5Smh0NxKBijAb+LtZ81hV4Lgo0uAiINqsx00v+Ogsey2gP2ur+3crBzZvq3qw4IeaGab8CZ3A5VOor5jZhb63J4WpZ5iWZ+2WlkdAMFQrzwI5VgCePKZvEMWzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031820; c=relaxed/simple;
	bh=RUi8a/oXJziJe7B0PMUjtOn3ES2ruWN1dSdhPuHmYmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwJzvQqQX9jnMk2uRVPqQTteOI2TCgFboPMGp3InVRUt7KnhKUkwiupfbF/lh/sbf3LzdZtDQn3VjC1MRfvlG/YoL2CmmjJHtXAN7gOa2eNHzaViMWwzkjPn5Ob/VhaIZNl6bqx/cIezmwhAwvHkf7poLsvRpeCq/aa1s0zIcqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blN9Cx43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294A9C4CED1;
	Thu, 20 Feb 2025 06:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740031819;
	bh=RUi8a/oXJziJe7B0PMUjtOn3ES2ruWN1dSdhPuHmYmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=blN9Cx43m6RLjI/m8V5yTRzgjIUnzbMEzWDa1GPMt+V3bZxUKZBsSCkheCSv4NMRX
	 lmwQ3poZXVj47GDRh94jE9HTKTtdFYZBxKEe5VQM9HMkME6gdfSF66+UgErALbaHrX
	 YP+elljPomxhLvvCJiMZa9a51vFonRnJUsPZvE1Kxl+3RjVPPdq0OEUUN2UGy9LlS3
	 UpihzmKbOK5KscvtJJwDSRK6ygxHvzTdj3rtAluQpQ0l9dn4iyIK/l1adZB8PSBKAu
	 JGRmskxNEbiIEm3fA38kBcwm7v0W8JWpegThiDY4pRpaHJefyvWcUkBgzgAd5tyqcZ
	 /V0HrpSsOqYaA==
Date: Thu, 20 Feb 2025 08:10:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: chenhuacai@kernel.org, kernel@xen0n.name, rafael@kernel.org,
	lenb@kernel.org, maobibo@loongson.cn, guanwentao@uniontech.com,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	dave.jiang@intel.com, haibo1.xu@intel.com,
	linux-acpi@vger.kernel.org, zhanjun@uniontech.com,
	niecheng1@uniontech.com, chenlinxuan@uniontech.com
Subject: Re: [PATCH] ACPI: NUMA: Move get_numa_distances_cnt() helper to
 needed location
Message-ID: <Z7bHPVUH4lAezk0E@kernel.org>
References: <D87315C93AF20D4E+20250220042037.942802-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D87315C93AF20D4E+20250220042037.942802-1-wangyuli@uniontech.com>

Hi,

On Thu, Feb 20, 2025 at 12:20:37PM +0800, WangYuli wrote:
> In LoongArch, get_numa_distances_cnt() was not in use, resulting in
> a compiler warning.
> 
> Serendipitously, drivers/acpi/numa/srat.c appears to be a more
> relevant location for this helper function, hence its relocation.

There's no need for relocation, just drop the unused function.
 
> This commit not only resolves these immediate concerns but also sets
> the groundwork for potential future integration of ACPI related logic
> from other architectures into this driver module.
> 
> Separately, the locality_count member in struct acpi_table_slit is
> typed as u64. Adapt the function type to eliminate potential code
> risks.
> 
> Fix follow errors with clang-18 when W=1e:
> 
> arch/loongarch/kernel/acpi.c:259:28: error: unused function 'get_numa_distances_cnt' [-Werror,-Wunused-function]
>   259 | static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
>       |                            ^~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  arch/loongarch/kernel/acpi.c |  5 -----
>  drivers/acpi/numa/srat.c     | 13 +++++++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index ee471a80763e..90cc9250f121 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -256,11 +256,6 @@ static __init int setup_node(int pxm)
>   */
>  unsigned int numa_distance_cnt;
>  
> -static inline unsigned int get_numa_distances_cnt(struct acpi_table_slit *slit)
> -{
> -	return slit->locality_count;
> -}
> -
>  void __init numa_set_distance(int from, int to, int distance)
>  {
>  	if ((u8)distance != distance || (from == to && distance != LOCAL_DISTANCE)) {
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..36053ae3dad6 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -283,6 +283,11 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  	}
>  }
>  
> +static inline u64 get_numa_distances_cnt(struct acpi_table_slit *slit)
> +{
> +	return slit->locality_count;
> +}
> +
>  /*
>   * A lot of BIOS fill in 10 (= no distance) everywhere. This messes
>   * up the NUMA heuristics which wants the local node to have a smaller
> @@ -292,7 +297,7 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  static int __init slit_valid(struct acpi_table_slit *slit)
>  {
>  	int i, j;
> -	int d = slit->locality_count;
> +	u64 d = get_numa_distances_cnt(slit);
>  	for (i = 0; i < d; i++) {
>  		for (j = 0; j < d; j++) {
>  			u8 val = slit->entry[d*i + j];
> @@ -337,20 +342,20 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < slit->locality_count; i++) {
> +	for (i = 0; i < get_numa_distances_cnt(slit); i++) {
>  		const int from_node = pxm_to_node(i);
>  
>  		if (from_node == NUMA_NO_NODE)
>  			continue;
>  
> -		for (j = 0; j < slit->locality_count; j++) {
> +		for (j = 0; j < get_numa_distances_cnt(slit); j++) {
>  			const int to_node = pxm_to_node(j);
>  
>  			if (to_node == NUMA_NO_NODE)
>  				continue;
>  
>  			numa_set_distance(from_node, to_node,
> -				slit->entry[slit->locality_count * i + j]);
> +				slit->entry[get_numa_distances_cnt(slit) * i + j]);
>  		}
>  	}
>  
> -- 
> 2.47.2
> 

-- 
Sincerely yours,
Mike.

