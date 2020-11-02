Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95D22A236F
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Nov 2020 04:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgKBDQl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Nov 2020 22:16:41 -0500
Received: from mail-m975.mail.163.com ([123.126.97.5]:34304 "EHLO
        mail-m975.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgKBDQl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Nov 2020 22:16:41 -0500
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2020 22:16:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=lXwaQrWIdCXZ6PlGhd
        kX3I2mUU2pN9IG+szcUH0GBkI=; b=OubofUGmWnj0BHKIENS0S0i4cmzbxGU4hY
        /xXOhSo/bQFn+ii4UB7zqIlai3m5Nz1H/EkBjm6Q/N2KYDkPhLMA29o0D6OAFXGV
        bDiv3G4Bnd6VkvjgGuzqQjGYoteKvlMu7Kifwp4R3Z0ejq7IRHceq8WIfk1phB6C
        fjNEErdy4=
Received: from smtp.163.com (unknown [36.112.24.9])
        by smtp5 (Coremail) with SMTP id HdxpCgBXvclfdp9fk0dhCQ--.18S2;
        Mon, 02 Nov 2020 11:00:51 +0800 (CST)
From:   yaoaili126@163.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
        linux-acpi@vger.kernel.org, yangfeng1@kingsoft.com,
        yaoaili@kingsoft.com
Subject: RE: [PATCH] ACPI, APEI, Fix incorrect return value of apei_map_generic_address
Date:   Sun,  1 Nov 2020 19:00:47 -0800
Message-Id: <20201102030047.8452-1-yaoaili126@163.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201102023332.7638-1-yaoaili126 () 163 ! com>
References: <20201102023332.7638-1-yaoaili126 () 163 ! com>
X-CM-TRANSID: HdxpCgBXvclfdp9fk0dhCQ--.18S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF48Zry3Kw13WFWkKFyUWrg_yoW7ZFyfpF
        W8uFWrCrWFqr4xGw4xZr1UKry5Zw1kGayaq3srK3sY9F1UGrWxCrWDWFWUXr4rGrW8Ww4r
        Xan8Krs8Ca9FvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UGFAJUUUUU=
X-Originating-IP: [36.112.24.9]
X-CM-SenderInfo: 51drtxdolrjli6rwjhhfrp/xtbBFAPQG1aD88EusgAAsn
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I am really sorry for this error mail, This mix other modification for other 
issue that have not been tested!
Please ingore this mail, and I will re-submit.
Sorry for This!

> -----Original Message-----
> From: yaoaili126@163.com [mailto:yaoaili126@163.com]
> Sent: Monday, November 2, 2020 10:34 AM
> To: rjw@rjwysocki.net; lenb@kernel.org
> Cc: james.morse@arm.com; tony.luck@intel.com; bp@alien8.de; linux-
> acpi@vger.kernel.org; YANGFENG1<YANGFENG1@kingsoft.com>;
> yaoaili<yaoaili@kingsoft.com>
> Subject: [PATCH] ACPI, APEI, Fix incorrect return value of
> apei_map_generic_address
> 
> From: Aili Yao <yaoaili@kingsoft.com>
> 
> From commit 6915564dc5a8 ("ACPI: OSL: Change the type of
> acpi_os_map_generic_address() return
> value"),acpi_os_map_generic_address
> will return logical address or NULL for error, but pre_map_gar_callback and
> related apei_map_generic_address ,for ACPI_ADR_SPACE_SYSTEM_IO case,
> it should be also return 0,as it's a normal case, but now it will return -ENXIO.
> so check it out for such case to avoid einj module initialization fail.
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  2 +
>  drivers/acpi/apei/apei-base.c  |  4 ++
>  drivers/acpi/apei/ghes.c       | 67 ++++++++++++++++++++++++++++++++++
>  include/acpi/ghes.h            |  2 +
>  4 files changed, 75 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c
> b/arch/x86/kernel/cpu/mce/core.c index 4102b866e7c0..22efa708ef53
> 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -341,6 +341,8 @@ static void mce_panic(const char *msg, struct mce
> *final, char *exp)
>  		if (!apei_err)
>  			apei_err = apei_write_mce(final);
>  	}
> +	/* Print possible additional cper error info, get cper cleared */
> +	ghes_in_mce_cper_entry_check();
>  	if (cpu_missing)
>  		pr_emerg(HW_ERR "Some CPUs didn't answer in
> synchronization\n");
>  	if (exp)
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 552fd9ffaca4..3294cc8dc073 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -633,6 +633,10 @@ int apei_map_generic_address(struct
> acpi_generic_address *reg)
>  	if (rc)
>  		return rc;
> 
> +	/* IO space doesn't need mapping */
> +	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO)
> +		return 0;
> +
>  	if (!acpi_os_map_generic_address(reg))
>  		return -ENXIO;
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
> fce7ade2aba9..6f5d89b54561 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1147,9 +1147,76 @@ static void ghes_nmi_remove(struct ghes *ghes)
>  	 */
>  	synchronize_rcu();
>  }
> +
> +int ghes_in_mce_cper_entry_check(void)
> +{
> +	int rc = -ENOENT;
> +	struct ghes *ghes;
> +	struct list_head *rcu_list = &ghes_nmi;
> +	enum fixed_addresses fixmap_idx = FIX_APEI_GHES_NMI;
> +	struct acpi_hest_generic_status *estatus, tmp_header;
> +	struct ghes_estatus_node *estatus_node;
> +	u32 len, node_len;
> +	u64 buf_paddr;
> +	int sev;
> +
> +	/* if NMI handler already in process, let NMI do its job */
> +	if (!atomic_add_unless(&ghes_in_nmi, 1, 1))
> +		return 0;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(ghes, rcu_list, list) {
> +		rc = __ghes_peek_estatus(ghes, &tmp_header, &buf_paddr,
> fixmap_idx);
> +		if (rc) {
> +			ghes_clear_estatus(ghes, &tmp_header, buf_paddr,
> fixmap_idx);
> +			return rc;
> +		}
> +
> +		rc = __ghes_check_estatus(ghes, &tmp_header);
> +		if (rc) {
> +			ghes_clear_estatus(ghes, &tmp_header, buf_paddr,
> fixmap_idx);
> +			return rc;
> +		}
> +
> +		len = cper_estatus_len(&tmp_header);
> +		node_len = GHES_ESTATUS_NODE_LEN(len);
> +		estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool,
> node_len);
> +		if (!estatus_node) {
> +			/*
> +			 * Going to panic, No need to keep the error.
> +			 */
> +			ghes_clear_estatus(ghes, &tmp_header, buf_paddr,
> fixmap_idx);
> +			return -ENOMEM;
> +		}
> +		estatus_node->ghes = ghes;
> +		estatus_node->generic = ghes->generic;
> +		estatus_node->task_work.func = NULL;
> +		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> +
> +		if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len))
> {
> +			ghes_clear_estatus(ghes, estatus, buf_paddr,
> fixmap_idx);
> +			return -ENOENT;
> +		}
> +
> +		/*
> +		 * As we are going to panic, and preemt the possible NMI
> handing,
> +		 * dump all the info and get it cleared.
> +		 */
> +		ghes_print_queued_estatus();
> +		__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
> +		ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
> +
> +		gen_pool_free(ghes_estatus_pool, (unsigned
> long)estatus_node,
> +		      node_len);
> +	}
> +	rcu_read_unlock();
> +	atomic_dec(&ghes_in_nmi);
> +	return rc;
> +}
>  #else /* CONFIG_HAVE_ACPI_APEI_NMI */
>  static inline void ghes_nmi_add(struct ghes *ghes) { }  static inline void
> ghes_nmi_remove(struct ghes *ghes) { }
> +int ghes_in_mce_cper_entry_check(void) {}
>  #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
> 
>  static void ghes_nmi_init_cxt(void)
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h index
> 34fb3431a8f3..be1ee0e993d2 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -145,4 +145,6 @@ int ghes_notify_sea(void);  static inline int
> ghes_notify_sea(void) { return -ENOENT; }  #endif
> 
> +int ghes_in_mce_cper_entry_check(void);
> +
>  #endif /* GHES_H */
> --
> 2.18.4

Thanks
Aili Yao

