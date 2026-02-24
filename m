Return-Path: <linux-acpi+bounces-21137-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD6lNlzGnWkkSAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21137-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 16:40:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D81892D1
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 16:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16ED531CEDEF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D1427B327;
	Tue, 24 Feb 2026 15:34:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA127380A;
	Tue, 24 Feb 2026 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947256; cv=none; b=meLGwaG2pG0YW/WBeePK5tAk5v6fkPI20/5w8S0HWj7/LUn+FYe+r0fdlbti5SDiUi+g6xMvtOM0HRDw+evwRI6dzDl5HNlGhDCOjk8qKjhPnzz25qItLfXFGj8hDH9TL1W4xkprHASjcEdh+LZTphmQRIoXkBXGa59BhiEoZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947256; c=relaxed/simple;
	bh=3UnJNpKBp41060PCCiUKh/z/XCpPqIeEtBlEINpW5VI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cX0ESuGgM/uDzcoc2wkhVpwGM44wgQZSuC4bVleKl4T8sciky9NkFfcfs1dKR1Pcdeyhdpl3sn/r0Be9aNssTe4qfyNNoNjwTsv+PwXR8t8H1vvny2ghO7FI4KM4W4BVegd8F1DpfKKK6ypf3WpmrZNcRG4IdRlme890AQZqkP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fL1wG0MXHzJ4678;
	Tue, 24 Feb 2026 23:33:50 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id C841E40573;
	Tue, 24 Feb 2026 23:34:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Feb
 2026 15:34:10 +0000
Date: Tue, 24 Feb 2026 15:34:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ahmed Tiba <ahmed.tiba@arm.com>
CC: <devicetree@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<Dmitry.Lamerov@arm.com>, <catalin.marinas@arm.com>, <bp@alien8.de>,
	<robh@kernel.org>, <rafael@kernel.org>, <will@kernel.org>,
	<conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <krzk+dt@kernel.org>, <Michael.Zhao2@arm.com>,
	<tony.luck@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] ACPI: APEI: GHES: move CXL CPER helpers
Message-ID: <20260224153409.0000191a@huawei.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-7-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
	<20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-7-347fa2d7351b@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-21137-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathan.cameron@huawei.com,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid]
X-Rspamd-Queue-Id: 513D81892D1
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 13:42:25 +0000
Ahmed Tiba <ahmed.tiba@arm.com> wrote:

> Move the CXL CPER handling paths out of ghes.c and into ghes_cper.c so the
> helpers can be reused. The code is moved as-is, with the public
> prototypes updated so GHES keeps calling into the new translation unit.
> 
> Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>

+CC linux-cxl.

I haven't looked closely but suspect the same stuff on code movement and patch
break up applies here.

Thanks,

Jonathan

> ---
>  drivers/acpi/apei/ghes.c      | 132 -----------------------------------------
>  drivers/acpi/apei/ghes_cper.c | 135 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/ghes_cper.h      |  11 ++++
>  3 files changed, 146 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 9703c602a8c2..136993704d52 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -383,138 +383,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> -/* Room for 8 entries */
> -#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
> -static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
> -		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
> -
> -/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
> -static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> -struct work_struct *cxl_cper_prot_err_work;
> -
> -static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> -				   int severity)
> -{
> -#ifdef CONFIG_ACPI_APEI_PCIEAER
> -	struct cxl_cper_prot_err_work_data wd;
> -
> -	if (cxl_cper_sec_prot_err_valid(prot_err))
> -		return;
> -
> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> -
> -	if (!cxl_cper_prot_err_work)
> -		return;
> -
> -	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> -		return;
> -
> -	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
> -		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> -		return;
> -	}
> -
> -	schedule_work(cxl_cper_prot_err_work);
> -#endif
> -}
> -
> -int cxl_cper_register_prot_err_work(struct work_struct *work)
> -{
> -	if (cxl_cper_prot_err_work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> -	cxl_cper_prot_err_work = work;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> -
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> -{
> -	if (cxl_cper_prot_err_work != work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> -	cxl_cper_prot_err_work = NULL;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> -
> -int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
> -{
> -	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> -
> -/* Room for 8 entries for each of the 4 event log queues */
> -#define CXL_CPER_FIFO_DEPTH 32
> -DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> -
> -/* Synchronize schedule_work() with cxl_cper_work changes */
> -static DEFINE_SPINLOCK(cxl_cper_work_lock);
> -struct work_struct *cxl_cper_work;
> -
> -static void cxl_cper_post_event(enum cxl_event_type event_type,
> -				struct cxl_cper_event_rec *rec)
> -{
> -	struct cxl_cper_work_data wd;
> -
> -	if (rec->hdr.length <= sizeof(rec->hdr) ||
> -	    rec->hdr.length > sizeof(*rec)) {
> -		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> -		       rec->hdr.length);
> -		return;
> -	}
> -
> -	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> -		pr_err(FW_WARN "CXL CPER invalid event\n");
> -		return;
> -	}
> -
> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> -
> -	if (!cxl_cper_work)
> -		return;
> -
> -	wd.event_type = event_type;
> -	memcpy(&wd.rec, rec, sizeof(wd.rec));
> -
> -	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> -		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> -		return;
> -	}
> -
> -	schedule_work(cxl_cper_work);
> -}
> -
> -int cxl_cper_register_work(struct work_struct *work)
> -{
> -	if (cxl_cper_work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = work;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
> -
> -int cxl_cper_unregister_work(struct work_struct *work)
> -{
> -	if (cxl_cper_work != work)
> -		return -EINVAL;
> -
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = NULL;
> -	return 0;
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
> -
> -int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> -{
> -	return kfifo_get(&cxl_cper_fifo, wd);
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
> -
>  static void ghes_log_hwerr(int sev, guid_t *sec_type)
>  {
>  	if (sev != CPER_SEV_RECOVERABLE)
> diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
> index 627f6c712261..673dca208935 100644
> --- a/drivers/acpi/apei/ghes_cper.c
> +++ b/drivers/acpi/apei/ghes_cper.c
> @@ -9,10 +9,12 @@
>   *
>   */
>  
> +#include <linux/aer.h>
>  #include <linux/err.h>
>  #include <linux/genalloc.h>
>  #include <linux/irq_work.h>
>  #include <linux/io.h>
> +#include <linux/kfifo.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/math64.h>
> @@ -319,6 +321,139 @@ void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  	schedule_work(&entry->work);
>  }
>  
> +
> +/* Room for 8 entries */
> +#define CXL_CPER_PROT_ERR_FIFO_DEPTH 8
> +static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
> +		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
> +
> +/* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
> +static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> +struct work_struct *cxl_cper_prot_err_work;
> +
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +				   int severity)
> +{
> +#ifdef CONFIG_ACPI_APEI_PCIEAER
> +	struct cxl_cper_prot_err_work_data wd;
> +
> +	if (cxl_cper_sec_prot_err_valid(prot_err))
> +		return;
> +
> +	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +
> +	if (!cxl_cper_prot_err_work)
> +		return;
> +
> +	if (cxl_cper_setup_prot_err_work_data(&wd, prot_err, severity))
> +		return;
> +
> +	if (!kfifo_put(&cxl_cper_prot_err_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_prot_err_work);
> +#endif
> +}
> +
> +int cxl_cper_register_prot_err_work(struct work_struct *work)
> +{
> +	if (cxl_cper_prot_err_work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	cxl_cper_prot_err_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> +
> +int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +{
> +	if (cxl_cper_prot_err_work != work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	cxl_cper_prot_err_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> +
> +int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> +
> +/* Room for 8 entries for each of the 4 event log queues */
> +#define CXL_CPER_FIFO_DEPTH 32
> +DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
> +
> +/* Synchronize schedule_work() with cxl_cper_work changes */
> +static DEFINE_SPINLOCK(cxl_cper_work_lock);
> +struct work_struct *cxl_cper_work;
> +
> +void cxl_cper_post_event(enum cxl_event_type event_type,
> +				struct cxl_cper_event_rec *rec)
> +{
> +	struct cxl_cper_work_data wd;
> +
> +	if (rec->hdr.length <= sizeof(rec->hdr) ||
> +	    rec->hdr.length > sizeof(*rec)) {
> +		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> +		       rec->hdr.length);
> +		return;
> +	}
> +
> +	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
> +		pr_err(FW_WARN "CXL CPER invalid event\n");
> +		return;
> +	}
> +
> +	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +
> +	if (!cxl_cper_work)
> +		return;
> +
> +	wd.event_type = event_type;
> +	memcpy(&wd.rec, rec, sizeof(wd.rec));
> +
> +	if (!kfifo_put(&cxl_cper_fifo, wd)) {
> +		pr_err_ratelimited("CXL CPER kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_cper_work);
> +}
> +
> +int cxl_cper_register_work(struct work_struct *work)
> +{
> +	if (cxl_cper_work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_work_lock);
> +	cxl_cper_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
> +
> +int cxl_cper_unregister_work(struct work_struct *work)
> +{
> +	if (cxl_cper_work != work)
> +		return -EINVAL;
> +
> +	guard(spinlock)(&cxl_cper_work_lock);
> +	cxl_cper_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
> +
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
> +{
> +	return kfifo_get(&cxl_cper_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
> +
>  /*
>   * GHES error status reporting throttle, to report more kinds of
>   * errors, instead of just most frequently occurred errors.
> diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
> index c5ff4c502017..4522e8699ce0 100644
> --- a/include/acpi/ghes_cper.h
> +++ b/include/acpi/ghes_cper.h
> @@ -15,6 +15,7 @@
>  #include <linux/workqueue.h>
>  
>  #include <acpi/ghes.h>
> +#include <cxl/event.h>
>  
>  #define GHES_PFX	"GHES: "
>  
> @@ -99,5 +100,15 @@ void ghes_estatus_cache_add(struct acpi_hest_generic *generic,
>  			    struct acpi_hest_generic_status *estatus);
>  void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>  				   int sev);
> +void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> +			    int severity);
> +int cxl_cper_register_prot_err_work(struct work_struct *work);
> +int cxl_cper_unregister_prot_err_work(struct work_struct *work);
> +int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
> +void cxl_cper_post_event(enum cxl_event_type event_type,
> +			 struct cxl_cper_event_rec *rec);
> +int cxl_cper_register_work(struct work_struct *work);
> +int cxl_cper_unregister_work(struct work_struct *work);
> +int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
>  
>  #endif /* ACPI_APEI_GHES_CPER_H */
> 


