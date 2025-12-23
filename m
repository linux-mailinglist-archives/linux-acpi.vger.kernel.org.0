Return-Path: <linux-acpi+bounces-19829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E73F0CD9B0C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 15:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C44A43018340
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Dec 2025 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC2C326D63;
	Tue, 23 Dec 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lhYdYOxO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D11332EA2
	for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500673; cv=none; b=ECsuLl+xTtRj+USIyHIbXn9eN0umi5DKW0zmqhDHo78hw+lYAnQemBxii3Kccdg97X9jLgAw6ZTnWxaWc46eW2c0t0uuSVPtViNMhdceRsgTAGUH/p1E/mMR/Ku+4+MITlFjCfPTal3GI2YsMX5G+un5d1Ht+IuLSXfdDfLsRa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500673; c=relaxed/simple;
	bh=7L4fJ5DuGs5Yl3TLRh5l1wVl6Uuizv4s/kwtIHODiQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eAnwD2G9lUxLXw0MH+BZhe8/ZkRHDUN1Gj6Ho18/ZJLRSrt6Z6flxg9zmW9s8D1QuaSY1jYaeaYkycgfKhuknVNa8kIQ8oce3lb3Wnyj8k4+fLElfKlXnTshkvgDz2cCSt1QoWedCZFSUbeYzL2BKfSAVUrt7ctaA/gSgvQPp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lhYdYOxO; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k1YlkzfZsykbU1rAj1bNdTerN111b3z9nDI+l11wZD8=;
	b=lhYdYOxOHrD4Q6MAkS20wjZ0zPmCUIjZavhm95SeISGCY4eTX1weRvwo9P0jQ9pcSdAnDz2bD
	absoi5hg6a+O3qlLN5HjFnDadrkzEXguCSriEV0VwTzlZyE1TTJ/f1lTdimEC7NPeW6RumU8y7D
	qpza4CNjQNNxHmBzHL6mM6U=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dbHbp6gK0z1T4GK
	for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 22:35:18 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id C77F04056A
	for <linux-acpi@vger.kernel.org>; Tue, 23 Dec 2025 22:37:39 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 22:37:39 +0800
Message-ID: <b7afc2e0-4d22-4f22-86ed-f25a262f2d54@huawei.com>
Date: Tue, 23 Dec 2025 22:37:38 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH]{topost} perf: Add --uncorepmu option for filtering
 uncore PMUs
To: <wangyushan12@huawei.com>, <hejunhao3@h-partners.com>,
	<jonathan.cameron@huawei.com>
CC: <linux-acpi@vger.kernel.org>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>
References: <20251223142854.461214-1-xiaqinxin@huawei.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <20251223142854.461214-1-xiaqinxin@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)

Please ignore.
On 2025/12/23 22:28:54, Qinxin Xia <xiaqinxin@huawei.com> wrote:
> This patch adds a new --uncorepmu option to perf-stat command to allow
> filtering events on specific uncore PMUs. This is useful when there are
> multiple uncore PMUs with the same type (e.g. hisi_sccl1_ddrc0_0 and
> hisi_sccl1_ddrc0_1).
> The option works similarly to the existing --cputype option for hybrid
> CPUs, but for uncore PMUs.
> 
> ./perf stat --uncorepmu hisi_sicl2_cpa0 -M cpa_p1_avg_bw
> 
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> ---
>   tools/perf/Documentation/perf-stat.txt |  4 ++++
>   tools/perf/builtin-stat.c              | 26 ++++++++++++++++++++++++++
>   tools/perf/util/metricgroup.c          | 18 +++++++++++++-----
>   3 files changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 1a766d4a2233..9c0952b43a57 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -573,6 +573,10 @@ $ perf config stat.no-csv-summary=true
>   Only enable events on applying cpu with this type for hybrid platform
>   (e.g. core or atom)"
>   
> +--uncorepmu::
> +Only enable events on applying uncore pmu with specified for multiple
> +uncore pmus with same type (e.g. hisi_sccl1_ddrc0_0 or hisi_sccl1_ddrc0_1)
> +
>   EXAMPLES
>   --------
>   
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ab40d85fb125..3f34bfc79179 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1235,6 +1235,28 @@ static int parse_cputype(const struct option *opt,
>   	return 0;
>   }
>   
> +static int parse_uncorepmu(const struct option *opt,
> +			   const char *str,
> +			   int unset __maybe_unused)
> +{
> +	const struct perf_pmu *pmu;
> +	struct evlist *evlist = *(struct evlist **)opt->value;
> +
> +	if (!list_empty(&evlist->core.entries)) {
> +		fprintf(stderr, "Must define uncorepmu before events/metrics\n");
> +		return -1;
> +	}
> +
> +	pmu = perf_pmus__pmu_for_pmu_filter(str);
> +	if (!pmu || pmu->is_core) {
> +		fprintf(stderr, "--uncorepmu %s is not supported!\n", str);
> +		return -1;
> +	}
> +	parse_events_option_args.pmu_filter = pmu->name;
> +
> +	return 0;
> +}
> +
>   static int parse_cache_level(const struct option *opt,
>   			     const char *str,
>   			     int unset __maybe_unused)
> @@ -2579,6 +2601,10 @@ int cmd_stat(int argc, const char **argv)
>   			"Only enable events on applying cpu with this type "
>   			"for hybrid platform (e.g. core or atom)",
>   			parse_cputype),
> +		OPT_CALLBACK(0, "uncorepmu", &evsel_list, "uncore pmu",
> +			"Only enable events on applying uncore pmu with specified "
> +			"for multiple uncore pmus with same type(e.g. hisi_sccl1_ddrc0_0 or hisi_sccl1_ddrc0_1)",
> +			parse_uncorepmu),
>   #ifdef HAVE_LIBPFM
>   		OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
>   			"libpfm4 event selector. use 'perf list' to list available events",
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 25c75fdbfc52..59ef71df20bd 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -387,8 +387,13 @@ static bool match_pm_metric_or_groups(const struct pmu_metric *pm, const char *p
>   				      const char *metric_or_groups)
>   {
>   	const char *pm_pmu = pm->pmu ?: "cpu";
> +	struct perf_pmu *perf_pmu = NULL;
>   
> -	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu))
> +	if (pm->pmu)
> +		perf_pmu = perf_pmus__find(pm->pmu);
> +
> +	if (strcmp(pmu, "all") && strcmp(pm_pmu, pmu) &&
> +	   (perf_pmu && !perf_pmu__name_wildcard_match(perf_pmu, pmu)))
>   		return false;
>   
>   	return match_metric_or_groups(pm->metric_group, metric_or_groups) ||
> @@ -1260,7 +1265,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>   static int parse_ids(bool metric_no_merge, bool fake_pmu,
>   		     struct expr_parse_ctx *ids, const char *modifier,
>   		     bool group_events, const bool tool_events[TOOL_PMU__EVENT_MAX],
> -		     struct evlist **out_evlist)
> +		     struct evlist **out_evlist,
> +		     const char *filter_pmu)
>   {
>   	struct parse_events_error parse_error;
>   	struct evlist *parsed_evlist;
> @@ -1314,7 +1320,7 @@ static int parse_ids(bool metric_no_merge, bool fake_pmu,
>   	}
>   	pr_debug("Parsing metric events '%s'\n", events.buf);
>   	parse_events_error__init(&parse_error);
> -	ret = __parse_events(parsed_evlist, events.buf, /*pmu_filter=*/NULL,
> +	ret = __parse_events(parsed_evlist, events.buf, filter_pmu,
>   			     &parse_error, fake_pmu, /*warn_if_reordered=*/false,
>   			     /*fake_tp=*/false);
>   	if (ret) {
> @@ -1417,7 +1423,8 @@ static int parse_groups(struct evlist *perf_evlist,
>   					/*modifier=*/NULL,
>   					/*group_events=*/false,
>   					tool_events,
> -					&combined_evlist);
> +					&combined_evlist,
> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>   		}
>   		if (combined)
>   			expr__ctx_free(combined);
> @@ -1472,7 +1479,8 @@ static int parse_groups(struct evlist *perf_evlist,
>   		}
>   		if (!metric_evlist) {
>   			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
> -					m->group_events, tool_events, &m->evlist);
> +					m->group_events, tool_events, &m->evlist,
> +					(pmu && strcmp(pmu, "all") == 0) ? NULL : pmu);
>   			if (ret)
>   				goto out;
>   

-- 
Thanks,
Qinxin


