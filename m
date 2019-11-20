Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7144103785
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2019 11:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfKTKai (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Nov 2019 05:30:38 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfKTKai (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Nov 2019 05:30:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47HzVK1tJ2z9sPL;
        Wed, 20 Nov 2019 21:30:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1574245836;
        bh=NoZPjg+0nioBWvif4gw1spRKoX1kFqqPPof1Rda5KVs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aLedtDwBTRHLQE3y5ARLngDZMOd0WLJxz56poFpD5/TLbHjLLMPY+g+/dnvleNZ1A
         7h8lHBaEoVK5BuzEdb8LYbVma1lry1OivSstDcZFDBbZul9eOwM0dA9N/QpRX7T/4u
         hOW5bb+0IdgBat24zL5Kn9QMuNuuMX3swigIWYmqNbRv/2tevyK0k6I5Il6ozSK5br
         5t+ExnZxNVFvl+jeYCvtoCYOaC0AW3HZ/oetU9BtOifc7VpDEBqQVYCfQTAKcRdfFk
         I7281Q60xL/IDK4jdt7pZVMY3Brx0w6eqjliMF7kmPGMlcUyjtrmQWNBPfzlvPsBxE
         b04DPEpalr6Yw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        peterz@infradead.org, vishal.l.verma@intel.com,
        dave.hansen@linux.intel.com, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 16/18] powerpc/papr_scm: Switch to numa_map_to_online_node()
In-Reply-To: <157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401276263.43284.12616818803654229788.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Wed, 20 Nov 2019 21:30:31 +1100
Message-ID: <87lfsac01k.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:
> Now that the core exports numa_map_to_online_node() switch to that
> instead of the locally coded duplicate.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Reported-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/powerpc/platforms/pseries/papr_scm.c |   21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 33aa59e666e5..ef81515f3b6a 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -284,25 +284,6 @@ int papr_scm_ndctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>  	return 0;
>  }
>  
> -static inline int papr_scm_node(int node)
> -{
> -	int min_dist = INT_MAX, dist;
> -	int nid, min_node;
> -
> -	if ((node == NUMA_NO_NODE) || node_online(node))
> -		return node;
> -
> -	min_node = first_online_node;
> -	for_each_online_node(nid) {
> -		dist = node_distance(node, nid);
> -		if (dist < min_dist) {
> -			min_dist = dist;
> -			min_node = nid;
> -		}
> -	}
> -	return min_node;
> -}
> -
>  static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  {
>  	struct device *dev = &p->pdev->dev;
> @@ -347,7 +328,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
>  
>  	memset(&ndr_desc, 0, sizeof(ndr_desc));
>  	target_nid = dev_to_node(&p->pdev->dev);
> -	online_nid = papr_scm_node(target_nid);
> +	online_nid = numa_map_to_online_node(target_nid);
>  	ndr_desc.numa_node = online_nid;
>  	ndr_desc.target_node = target_nid;
>  	ndr_desc.res = &p->res;
